#!/bin/bash
# /etc/vzdump.conf - default settings can be changed here

SCRIPT=$(realpath "$0")
SCRIPT_DIR=$(dirname "$SCRIPT")
NODENAME=$(hostname)

COMMAND=${1}

if [[ ${COMMAND} == 'backup-end' ]]; then
    echo "Backing up $TARGET to $HOSTNAME/"
    rclone --config /root/.config/rclone/rclone.conf --drive-chunk-size=32M sync $TARGET GoogleDrive:/Backups/Proxmox/$NODENAME/$HOSTNAME --exclude '*.log' -v --stats=60s --transfers=16 --checkers=16
elif [[ ${COMMAND} == 'job-end' ]]; then
    . ${SCRIPT_DIR}/cleanup-backups.sh 2
fi
