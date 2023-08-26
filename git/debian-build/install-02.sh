#!/bin/bash

# Section - 01 | Purpose - Check if script is Run as Root | Linked Resources - N/A
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Section - 12 | Purpose - Update repo mirrors & install Brave, LibreWolf and VSCodium | Linked Resources -
## Update repo mirrors
nala fetch --auto -y
nala update
nala upgrade -y
## Install Brave, LibreWolf and VSCodium
nala install -y brave-browser
nala install -y librewolf
nala install -y codium
nala install -y nextdns

