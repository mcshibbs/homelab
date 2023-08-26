#!/bin/bash

###This script does the following:
### Section 01 - Checks to see if script is run as Root
### Section 02 - Updates package list and updates system
### Section 03 - Installs nala, fetches best mirrors & updates mirrors
### Section 04 - PENDING - Installs timeshift and creates a snapshot
### Section 05 - Install and configure ZRAM-Tools - https://wiki.debian.org/ZRam
### Section 06 - Installs KDE-Plasma-Desktop
### Section 07 - PENDING - Creates cron job to run follow up script during next logon
### Section 08 - Restarts computer

# Section - 01
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install-0.sh" 2>&1
  exit 1
fi

# Section - 02
apt update
apt upgrade -y 

# Section - 03
apt install -y nala
nala fetch --auto -y
nala update
nala upgrade -y

# Section - 04

# Section - 05 
nala install -y zram-tools
echo -e "ALGO=zstd\nPERCENT=25" | sudo tee -a /etc/default/zramswap
sudo service zramswap reload

# Section - 06
nala install -y kde-plasma-desktop

# Section - 07

# Section - 08
shutdown -r now