function vpick --description "Pick a libvirt VM with fzf and act (ssh/start/stop/reboot/xml)"
    set -l uri qemu:///system

    function __vip --no-scope-shadowing
        set -l vm $argv[1]
        set -l ip (virsh -c $uri domifaddr $vm 2>/dev/null | awk '/ipv4/ {print $4}' | sed 's#/.*##' | head -n1)
        if test -n "$ip"
            echo $ip
            return 0
        end
        set -l mac (virsh -c $uri domiflist $vm 2>/dev/null | awk '/network/ {print $5}' | head -n1)
        if test -z "$mac"
            return 1
        end
        set -l ip2 (virsh -c $uri net-dhcp-leases default 2>/dev/null | awk -v mac="$mac" 'tolower($0) ~ tolower(mac) {print $5}' | sed 's#/.*##' | head -n1)
        test -n "$ip2"; and echo $ip2
    end

    set -l names (virsh -c $uri list --all --name | sed '/^$/d')
    if test (count $names) -eq 0
        echo "No VMs found in $uri"
        return 1
    end

    set -l rows
    for vm in $names
        set -l state (virsh -c $uri domstate $vm 2>/dev/null | tr -d '\r')
        set -l ip (__vip $vm 2>/dev/null)
        test -z "$ip"; and set ip -
        set rows $rows (printf "%-18s  %-10s  %s" $vm $state $ip)
    end

    set -l header "enter=ssh  ctrl-s=start  ctrl-d=shutdown  ctrl-r=reboot  ctrl-x=xml  esc=quit"

    # IMPORTANT: capture fzf output as multiple lines (fish does this correctly)
    set -l out (printf "%s\n" $rows | fzf --header="$header" --prompt="libvirt> " \
    --bind "ctrl-s:accept,ctrl-d:accept,ctrl-r:accept,ctrl-x:accept" \
    --expect=enter,ctrl-s,ctrl-d,ctrl-r,ctrl-x)

    if test (count $out) -eq 0
        return 0
    end

    set -l key $out[1]
    set -l line $out[2]

    if test -z "$line"
        return 0
    end

    set -l vm (string split -f1 " " -- (string trim -- $line))

    switch $key
        case ctrl-s
            virsh -c $uri start $vm
        case ctrl-d
            virsh -c $uri shutdown $vm
        case ctrl-r
            virsh -c $uri reboot $vm
        case ctrl-x
            virsh -c $uri dumpxml $vm | grep -nE "cdrom|source file|seeds|target dev"
        case enter '*'
            if ssh -G $vm >/dev/null 2>&1
                ssh $vm
            else
                set -l ip (__vip $vm)
                if test -z "$ip"
                    echo "No IP found for $vm (install qemu-guest-agent or check DHCP leases)"
                    return 1
                end
                ssh devops@$ip
            end
    end
end
