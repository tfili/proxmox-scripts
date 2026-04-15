# Scripts for Proxmox Nodes

These scripts are meant to be run on the nodes directly.

## How to sync

Run this once to create the bin directory

```
cd ~
mkdir bin
cd bin
```

Run this whenever you want to sync up from github

```
wget https://raw.githubusercontent.com/tfili/proxmox-scripts/refs/heads/main/nodes/cleanup-backups.sh
wget https://raw.githubusercontent.com/tfili/proxmox-scripts/refs/heads/main/nodes/google-backup.sh
wget https://raw.githubusercontent.com/tfili/proxmox-scripts/refs/heads/main/nodes/lxc-update.sh
chmod 755 *.sh
```

## Configure Backups

In `/etc/vzdump.conf` add the following line at the bottom

```
script: /root/bin/google-backup.sh
```

Run the following to install rclone

```
apt update
apt install rclone -y
```

Authenticate to Google Drive by following https://rclone.org/drive/. Name the connection `GoogleDrive`.

## Files

### cleanup-backups.sh

This will be run by `google-backup.sh` when a job ends.

### google-backup.sh

This will copy the container backups to `Backups/Proxmox/[NODE NAME]/[CONTAINER]` in the Google Drive you are authenticated to.

### lxc-update.sh

This needs to be run manually

It accepts the following options
- `--start(-s)`: Container ID to start updating
- `--end(-s)`: Contaner ID to stop updating
- `--ignore(-i)`: Container IDs to ignore (can be specified multiple times)
