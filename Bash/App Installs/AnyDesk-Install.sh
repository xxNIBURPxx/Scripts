#!/bin/bash

# Make root script directory folder
cd /Users/Shared
mkdir _workfile
cd _workfile

# Download package
curl -O https://download.anydesk.com/anydesk.dmg

# Set the paths for the DMG file and the application to be installed
DMG_PATH="/Users/Shared/_workfile/anydesk.dmg"
APP_NAME="AnyDesk.app"

# Mount the DMG file
hdiutil attach "$DMG_PATH"

# Set the path for the PKG file to be installed
PKG_PATH="/Volumes/anydesk.pkg"

# Install the PKG file using the 'installer' command
sudo installer -pkg "$PKG_PATH" -target /

# Copy the application from the DMG to the Applications folder
cp -R "/Volumes/anydesk/$APP_NAME" /Applications/

# Unmount the DMG file
hdiutil detach "/Volumes/anydesk"

# Remove install files and directory
rm -r /Users/Shared/_workfile

echo "Installation completed."
