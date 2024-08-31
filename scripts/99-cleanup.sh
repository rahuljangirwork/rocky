#!/bin/bash

cleanup() {
    echo "Cleaning up installation files..."
    rm -rf /mnt/root/.bash_history
    echo "Installation complete."
}
