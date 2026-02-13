function vup --description "Start a libvirt domain"
    set -l uri qemu:///system
    virsh -c $uri start $argv[1]
end
