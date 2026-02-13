function vreboot --description "Reboot a libvirt domain"
    set -l uri qemu:///system
    virsh -c $uri reboot $argv[1]
end
