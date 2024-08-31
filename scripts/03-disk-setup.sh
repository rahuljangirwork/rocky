#!/bin/bash

disk_setup() {
    echo "Setting up disk partitions on $DISK..."

    parted -s "$DISK" mklabel gpt
    parted -s "$DISK" mkpart primary 1MiB 300MiB
    parted -s "$DISK" mkpart primary 300MiB 100%
    parted -s "$DISK" set 1 boot on

    mkfs.fat -F32 "${DISK}1"
    mkfs.ext4 "${DISK}2"

    mount "${DISK}2" /mnt
    mkdir -p /mnt/boot/efi
    mount "${DISK}1" /mnt/boot/efi
    genfstab -U /mnt >> /mnt/etc/fstab
}
