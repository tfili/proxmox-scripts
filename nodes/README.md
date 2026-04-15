# Scripts for Proxmox Nodes

These scripts are meant to be run on the nodes directly.

## How to sync

### cleanup-backups.sh

This will be run by `google-backup.sh` when a job ends.

### google-backup.sh

In `/etc/vzdump.conf` add the following line at the bottom

```
script: /root/bin/google-backup.sh
```

### lxc-update.sh

This needs to be run manually

It accepts the following options
- `--start(-s)`: Container ID to start updating
- `--end(-s)`: Contaner ID to stop updating
- `--ignore(-i)`: Container IDs to ignore (can be specified multiple times)
