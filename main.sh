#!/bin/bash

# Load all the scripts in order
source ./scripts/01-auto-detect.sh
source ./scripts/02-user-setup.sh
source ./scripts/03-disk-setup.sh
source ./scripts/04-system-install.sh
source ./scripts/05-software-install.sh
source ./scripts/06-post-install.sh
source ./scripts/99-cleanup.sh

# Run the installation process
main() {
    clear
    echo "Welcome to the Rocky Linux 9 Automated Installer"

    auto_detect
    user_setup
    disk_setup
    system_install
    software_install
    post_install
    cleanup

    echo "Installation complete. Please remove the installation media and reboot."
}

main
