#!/bin/bash

# Section - 01 | Purpose - Check if script is Run as Root | Linked Resources - N/A
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Section - 14 | Purpose - Install Joplin | Linked Resources - https://joplinapp.org/help/#desktop-applications
#
# Download and run bash script to install Joplin
su sean -c "wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash"

# Section - 15 | Purpose - Install Thunderbird | Linked Resources - 
#
# This should work if thunderbird updates to the most current version
wget -O thunderbird.tar.bz2 "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=en-US"
#
# Extract files to /opt directory
#
tar -xvf thunderbird.tar.bz2 -C /opt/;rm thunderbird.tar.bz2
#
# adding desktop file
cat > ./temp << "EOF"
[Desktop Entry]
Version=115.0
Type=Application
Name=Thunderbird
Comment=Mail
Exec=/opt/thunderbird/./thunderbird
Icon=/opt/thunderbird/chrome/icons/default/default128.png
Terminal=false
StartupNotify=false
EOF
cp ./temp /usr/share/applications/thunderbird.desktop;rm ./temp