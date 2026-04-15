#!/bin/bash
 
# Array of filenames to download
files=(
  "cleanup-backups.sh"
  "google-backup.sh"
  "lxc-update.sh"
)
 
# Base URL for raw GitHub content
BASE_URL="https://raw.githubusercontent.com/tfili/proxmox-scripts/refs/heads/main/nodes"
 
for file in "${files[@]}"; do
  echo "Downloading: $file"
  curl -O "${BASE_URL}/${file}"
 
  if [[ $? -eq 0 ]]; then
    chmod 755 "$file"
    echo "Permissions set to 755 for: $file"
  else
    echo "Failed to download: $file"
  fi
done