#!/bin/bash

auto_detect() {
    echo "Auto-detecting system settings..."

    # Detect available disks
    DISKS=$(lsblk -dno NAME,SIZE | grep -v loop | awk '{print "/dev/" $1 " (" $2 ")"}')
    echo "Available disks:"
    echo "$DISKS"
    read -p "Enter the disk to install Rocky Linux on (default: /dev/sda): " DISK
    DISK=${DISK:-/dev/sda}

    # Detect network interfaces
    NET_INTERFACES=$(ls /sys/class/net)
    echo "Available network interfaces:"
    echo "$NET_INTERFACES"
    read -p "Enter the network interface to configure (default: eth0): " NET_INTERFACE
    NET_INTERFACE=${NET_INTERFACE:-eth0}

    # Detect UEFI or Legacy BIOS
    if [ -d /sys/firmware/efi ]; then
        BOOT_MODE="UEFI"
    else
        BOOT_MODE="Legacy"
    fi
    echo "Boot mode detected: $BOOT_MODE"

    # Default time zone
    TIMEZONE=$(timedatectl | grep "Time zone" | awk '{print $3}')
    echo "Default time zone detected: $TIMEZONE"
    read -p "Enter the timezone (default: $TIMEZONE): " USER_TIMEZONE
    TIMEZONE=${USER_TIMEZONE:-$TIMEZONE}

    export DISK NET_INTERFACE BOOT_MODE TIMEZONE
}
