function safe-up --description "DNF upgrade with snapshot + retain last 3"
    set -l prefix auto-dnf-
    set -l snap $prefix(date "+%Y%m%d-%H%M")

    sudo snapper -c root create --description $snap

    sudo dnf upgrade --refresh -y
    sudo dnf autoremove -y
    sudo dnf clean packages

    set -l snaps (sudo snapper -c root list --columns number,description | \
        tail -n +2 | \
        awk -v p="$prefix" '$2 ~ "^"p {print $1}' | \
        sort -n)

    set -l count (count $snaps)
    if test $count -gt 3
        set -l remove_count (math $count - 3)
        for i in (seq 1 $remove_count)
            sudo snapper -c root delete $snaps[$i]
        end
    end
end
