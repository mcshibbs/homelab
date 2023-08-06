#!/bin/bash

# Section - 01 | Purpose - Check if script is Run as Root | Linked Resources - N/A
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Section - 08 | Purpose - Add repo for Brave browser main | Linked Resources - https://brave.com/linux/#release-channel-installation
#
# Add Brave Browser Release Repository
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Section - 09 | Purpose - Add repo for LibreWolf | Linked Resources - https://librewolf.net/installation/debian/
#
## Check distro
distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)
#
## Download gpg key
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
#
## Apply gpg key
sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

# Section - 10 | Purpose - Add repo for VSCodium | Linked Resources - https://vscodium.com/
#
# Add the GPG key of the repository:
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
# Add the repository:
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
#
# Section - 11 | Purpose - Apply repo mirrors and dependencies for NextDNS
sudo wget -qO /usr/share/keyrings/nextdns.gpg https://repo.nextdns.io/nextdns.gpg
echo "deb [signed-by=/usr/share/keyrings/nextdns.gpg] https://repo.nextdns.io/deb stable main" | sudo tee /etc/apt/sources.list.d/nextdns.list

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

# Section - 13 | Purpose - Add Bitwarden, Joplin, and KDE Plasma Extension to Brave | # Linked Resources
## Creates path to place extensions
EXTENSIONS_PATH=/opt/brave.com/brave/extensions
mkdir -p $EXTENSIONS_PATH
#
BITWARDEN_ID=nngceckbapebfimnlniiiahkandclblb
echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${BITWARDEN_ID}.json"
#
KDE_ID=cimiefiiaegbelhefglklhhakcgmhkai
echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${KDE_ID}.json"
#
JOPLIN_ID=alofnhikmmkdbbbgpnglcpdollgjjfek
echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${JOPLIN_ID}.json"
