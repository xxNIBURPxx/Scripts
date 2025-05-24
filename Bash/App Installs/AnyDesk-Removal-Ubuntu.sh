#!/bin/bash

# Function to check if AnyDesk is running and stop it
quit_anydesk() {
    echo "Checking if AnyDesk is running..."
    if pgrep -if "anydesk" > /dev/null; then
        echo "AnyDesk is running. Attempting to stop..."
        sudo systemctl stop anydesk.service 2>/dev/null
        sudo pkill -9 anydesk 2>/dev/null
        sleep 2
        if pgrep -if "anydesk" > /dev/null; then
            echo "Force killing AnyDesk..."
            sudo pkill -9 anydesk
        fi
    else
        echo "AnyDesk is not running."
    fi
}

# Function to remove AnyDesk files and dependencies
remove_anydesk_files() {
    echo "Uninstalling AnyDesk..."
    sudo apt-get remove --purge -y anydesk

    echo "Removing AnyDesk residual files..."
    sudo rm -rvf ~/.anydesk
    sudo rm -rvf ~/.config/anydesk
    sudo rm -rvf /etc/anydesk
    sudo rm -rvf /var/lib/anydesk
    sudo rm -rvf /usr/share/applications/anydesk.desktop
    sudo rm -rvf /usr/bin/anydesk
    sudo rm -rvf /usr/lib/anydesk

    echo "Cleaning up package lists..."
    sudo apt-get autoremove -y
    sudo apt-get autoclean -y

    echo "AnyDesk has been successfully removed."
}

# Ensure script is run with sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script requires sudo privileges. Please run with sudo."
    exit 1
fi

# Main script execution
echo "Starting AnyDesk uninstallation process..."
quit_anydesk
remove_anydesk_files

echo "Done."
