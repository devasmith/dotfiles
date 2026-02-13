function vssh --description "SSH into VM by name (or by IP via vip)"
    set -l vm $argv[1]
    if test -z "$vm"
        echo "Usage: vssh <vm> [ssh args...]"
        return 1
    end

    # If you already have Host entries like 'cp-1', 'worker-1' -> just use them:
    if ssh -G $vm >/dev/null 2>&1
        command ssh $vm $argv[2..-1]
        return $status
    end

    # Otherwise resolve IP
    set -l ip (vip $vm)
    or return 1
    command ssh devops@$ip $argv[2..-1]
end
