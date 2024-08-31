#!/bin/bash

user_setup() {
    echo "Setting up user accounts..."

    read -p "Enter the hostname for your system (default: rocky-linux): " HOSTNAME
    HOSTNAME=${HOSTNAME:-rocky-linux}

    read -p "Enter the username for the new user (default: rockyuser): " USERNAME
    USERNAME=${USERNAME:-rockyuser}

    read -s -p "Enter the password for the new user: " PASSWORD
    echo
    read -s -p "Confirm the password: " PASSWORD_CONFIRM
    echo

    if [[ "$PASSWORD" != "$PASSWORD_CONFIRM" ]]; then
        echo "Passwords do not match. Aborting."
        exit 1
    fi

    read -p "Disable root login? (y/n, default: y): " DISABLE_ROOT
    DISABLE_ROOT=${DISABLE_ROOT:-y}

    export HOSTNAME USERNAME PASSWORD DISABLE_ROOT
}
