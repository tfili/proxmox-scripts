#!/bin/bash

# job-end doesn't have a path
export PATH=$PATH:/usr/bin

COUNT="${1:-2}"
NODENAME=$(hostname)

last_prefix=""
current_count=0

rclone ls GoogleDrive:/Backups/Proxmox/$NODENAME/ | awk '{print $2}' | sort -r | while read -r file; do
    prefix=$(echo $file | awk 'match($0, /[A-Za-z0-9.-]+\/vzdump-(lxc|qemu)-[0-9]+-/){ print substr($0, RSTART, RLENGTH) }')
    if [[ "$prefix" == "$last_prefix" ]]; then
        ((current_count++))
    else
        last_prefix="$prefix"
        current_count=1
    fi

    if (( current_count > COUNT )); then
        echo "Deleting old backup: $file"
        rclone delete GoogleDrive:/Backups/Proxmox/"$file" --drive-use-trash=false
    else
        echo "Keeping backup: $file"
    fi
done
