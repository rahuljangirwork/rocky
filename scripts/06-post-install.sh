#!/bin/bash

post_install() {
    echo "Finalizing installation..."

    echo "$HOSTNAME" > /mnt/etc/hostname
    echo "127.0.0.1   $HOSTNAME" >> /mnt/etc/hosts

    chroot /mnt useradd -m -G wheel -s /bin/bash "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chroot /mnt chpasswd

    if [ "$DISABLE_ROOT" = "y" ]; then
        chroot /mnt passwd -l root
    fi

    echo "%wheel ALL=(ALL) ALL" > /mnt/etc/sudoers.d/wheel

    chroot /mnt timedatectl set-timezone "$TIMEZONE"
    chroot /mnt setenforce 1
    echo "SELINUX=enforcing" > /mnt/etc/selinux/config
}
