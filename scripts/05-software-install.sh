#!/bin/bash

software_install() {
    echo "Installing additional software packages..."

    chroot /mnt dnf install -y vim git wget curl net-tools htop firewalld
    chroot /mnt systemctl enable firewalld
    chroot /mnt systemctl enable chronyd

    echo "Configuring firewall..."
    chroot /mnt firewall-cmd --permanent --add-service=ssh
    chroot /mnt firewall-cmd --permanent --add-service=http
    chroot /mnt firewall-cmd --permanent --add-service=https
    chroot /mnt firewall-cmd --reload
}
