#!/bin/bash

# Section - 01
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install-0.sh" 2>&1
  exit 1
fi

# Section - 02
nala install -y apt-transport-https
nala install -y ca-certificates
nala install -y curl
nala install -y gnupg
nala install -y lsb-release
nala install -y unzip

# Section - 03
nala install -y cockpit
nala install -y cockpit-machines
nala install -y virt-manager

  #Start services for Cockpit (and Cockpit machines)
  systemctl start libvirtd
  systemctl start Cockpit

# Section - 04 
nala install -y celluloid
nala isntall -y flameshot
nala install -y gimp
#nala install -y ufw - If GUFW Failes run this and then rerun GUFW
nala install -y gufw
nala install -y htop
nala install -y keepassxc
nala install -y kitty
nala install -y micro
nala install -y neofetch
nala install -y neovim
nala install -y nextcloud-desktop
nala install -y qbittorrent
nala install -y remmina
nala install -y wireguard

# Section - 05
