#!/bin/bash

# Function to check if AnyDesk is running and quit it
quit_anydesk() {
    echo "Checking if AnyDesk is running..."
    if pgrep -x "AnyDesk" > /dev/null; then
        echo "AnyDesk is running. Attempting to quit..."
        osascript -e 'quit app "AnyDesk"'
        sleep 2
        if pgrep -x "AnyDesk" > /dev/null; then
            echo "Force killing AnyDesk..."
            pkill -9 "AnyDesk"
        fi
    else
        echo "AnyDesk is not running."
    fi
}

# Function to remove AnyDesk files
remove_anydesk_files() {
    echo "Removing AnyDesk from Applications..."
    rm -rf /Applications/AnyDesk.app

    echo "Removing AnyDesk related files from ~/Library..."
    rm -rf ~/Library/Preferences/com.anydesk.AnyDesk.plist
    rm -rf ~/Library/Application\ Support/AnyDesk
    rm -rf ~/Library/Logs/AnyDesk

    echo "AnyDesk has been successfully removed."
}

# Main script execution
echo "Starting AnyDesk uninstallation process..."
quit_anydesk
remove_anydesk_files

echo "Done."
