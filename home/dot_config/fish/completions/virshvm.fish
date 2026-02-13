function __libvirt_domains
    virsh -c qemu:///system list --all --name 2>/dev/null | sed '/^$/d'
end

for cmd in vup vdown vreboot vip vssh
    complete -c $cmd -f -a "(__libvirt_domains)"
end
