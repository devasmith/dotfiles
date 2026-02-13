function vms --description "List libvirt domains"
    set -l uri qemu:///system
    echo "ID  NAME        STATE"
    virsh -c $uri list --all
end
