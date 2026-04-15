#!/bin/bash

set -e

# Parse arguments
IGNORE=()
START=0
END=9999
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -s|--start)
        START="$2"
        shift # shift past argument name
        shift # shift past argument value
        ;;
        -e|--end)
        END="$2"
        shift # shift past argument name
        shift # shift past argument value
        ;;
        -i|--ignore)
        IGNORE+=("$2")
        shift # shift past argument name
        shift # shift past argument value
        ;;
        *)    # unknown option
        echo "Unknown option $1"
        exit 1
        ;;
    esac
done

# Get list of LXC containers
LXCS=$(pct list | awk 'NR>1 {print $1,$2,$NF}')

# Update each LXC container
while read -r lxcId lxcStatus lxcName; do
    # Skip containers below the start ID
    if (( lxcId < START )); then
        continue
    fi

    # Skip containers above the end ID
    if (( lxcId > END )); then
        continue
    fi

    # Skip ignored containers
    if [[ " ${IGNORE[@]} " =~ " ${lxcId} " ]]; then
        echo "Skipping LXC container: $lxcId (ignored)"
        continue
    fi

    # Check if container is running
    if [[ "$lxcStatus" != "running" ]]; then
        echo "Skipping LXC container: $lxcId (not running)"
        continue
    fi

    # Update the container
    echo "Updating LXC container: $lxcId ($lxcName)"
    pct exec $lxcId -- update -y

    # Reboot the container to apply updates
    pct stop $lxcId
    pct start $lxcId
done <<< "$LXCS"