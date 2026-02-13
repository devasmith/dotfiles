function vip --description "Get VM IPv4 (needs qemu-guest-agent or DHCP lease)"
    set -l uri qemu:///system
    set -l vm $argv[1]
    if test -z "$vm"
        echo "Usage: vip <vm>"
        return 1
    end

    # Try domifaddr first (best with guest-agent)
    set -l ip (virsh -c $uri domifaddr $vm 2>/dev/null | awk '/ipv4/ {print $4}' | sed 's#/.*##' | head -n1)
    if test -n "$ip"
        echo $ip
        return 0
    end

    # Fallback: try DHCP leases (works if using libvirt default network)
    set -l mac (virsh -c $uri domiflist $vm 2>/dev/null | awk '/network/ {print $5}' | head -n1)
    if test -z "$mac"
        echo "No MAC found for $vm"
        return 1
    end

    set -l ip2 (virsh -c $uri net-dhcp-leases default 2>/dev/null | awk -v mac="$mac" 'tolower($0) ~ tolower(mac) {print $5}' | sed 's#/.*##' | head -n1)
    if test -n "$ip2"
        echo $ip2
        return 0
    end

    echo "No IP found for $vm (enable qemu-guest-agent or check network)"
    return 1
end
