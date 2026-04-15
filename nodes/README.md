# Scripts for Proxmox Nodes

These scripts are meant to be run on the nodes directly.

## How to sync

Create a `/root/bin` directory if it doesn't exist. This is where all setup steps assume the scripts are located.

```bash
mkdir /root/bin
```

Run this from the `/root/bin` whenever you want to sync up from github

```bash
curl https://raw.githubusercontent.com/tfili/proxmox-scripts/refs/heads/main/nodes/install.sh | bash
```

## Configure Backups

In `/etc/vzdump.conf` add the following line at the bottom

```yaml
script: /root/bin/google-backup.sh
```

Run the following to install rclone

```bash
apt update
apt install rclone -y
```

Authenticate to Google Drive by following [the RClone instructions](https://rclone.org/drive/). You must name the connection `GoogleDrive` for the scripts to work.

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
