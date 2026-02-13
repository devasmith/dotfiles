function vdown --description "Shutdown a libvirt domain"
    set -l uri qemu:///system
    virsh -c $uri shutdown $argv[1]
end
