#!/bin/bash

system_install() {
    echo "Installing minimal Rocky Linux system on $DISK..."

    dnf --installroot=/mnt --releasever=9 groupinstall -y "Minimal Install"
    dnf --installroot=/mnt --releasever=9 install -y grub2-efi-x64 shim chrony

    echo "Configuring bootloader..."
    if [ "$BOOT_MODE" = "UEFI" ]; then
        grub2-install --target=x86_64-efi --efi-directory=/mnt/boot/efi --boot-directory=/mnt/boot --removable
    else
        grub2-install --target=i386-pc --boot-directory=/mnt/boot "$DISK"
    fi
    chroot /mnt grub2-mkconfig -o /boot/grub2/grub.cfg
}
