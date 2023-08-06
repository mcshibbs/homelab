#!/bin/bash

# Section - 01 | Purpose - Check if script is Run as Root | Linked Resources - N/A
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

nala fetch --auto -y
nala update
nala upgrade -y

# Section - 06 | Purpose - Installing dependencies and required software | Linked Resources - N/A
nala install -y apt-transport-https
nala install -y ca-certificates
nala install -y curl
nala isntall -y flameshot
nala install -y gnupg
nala install -y keepassxc
nala install -y lsb-release
nala install -y nextcloud-desktop
nala install -y ufw
nala install -y unzip
nala install -y wireguard
nala install -y zram-tools

#Possible requirement for Cockpit and Cockpit Machines
nala install -y cockpit
nala install -y cockpit-machines
nala install -y virt-manager

#Start services for Cockpit (and Cockpit machines)
systemctl start libvirtd
systemctl start Cockpit

# Section - 07 | Purpose - Installing tools & popular programs | Linked Resources - 
nala install -y celluloid
nala install -y gimp
nala install -y gufw
nala install -y htop
nala install -y kitty
nala install -y micro
nala install -y neofetch
nala install -y neovim
nala install -y qbittorrent
nala install -y remmina 
