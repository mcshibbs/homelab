#!/bin/bash

# Section - 01 | Purpose - Check if script is Run as Root | Linked Resources - N/A
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Section - 02 | Purpose - Update packages list and update system | Linked Resources - N/A
apt update
apt upgrade -y 

# Section - 03 | Purpose - Install nala | Linked Resources - N/A
apt install -y nala
nala fetch --auto -y
nala update
nala upgrade -y

# Section - 04 | Purpose - Install and configure timeshift | Linked resources -
nala install -y timeshift
timeshift --create --comments "Fresh Install"

# Section - 05 | Purpose - Installing desktop environment | Linked Resources - N/A
nala install -y kde-plasma-desktop

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
#nala install -y libvirtd

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

#nala install -y thunar

# Section - 08 | Purpose - Add repo for Brave browser main | Linked Resources - https://brave.com/linux/#release-channel-installation
#
# Add Brave Browser Release Repository 
#sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#
#echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# Section - 09 | Purpose - Add repo for LibreWolf | Linked Resources - https://librewolf.net/installation/debian/
#
## Check distro
#distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)
#
## Download gpg key
#wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
#
## Apply gpg key
#sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
#Types: deb
#URIs: https://deb.librewolf.net
#Suites: $distro
#Components: main
#Architectures: amd64
#Signed-By: /usr/share/keyrings/librewolf.gpg
#EOF 

# Section - 10 | Purpose - Add repo for VSCodium | Linked Resources - https://vscodium.com/
#
# Add the GPG key of the repository:
#wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
#    | gpg --dearmor \
#    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
# Add the repository:
#echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
#    | sudo tee /etc/apt/sources.list.d/vscodium.list
#
# Section - 11 | Purpose - Apply repo mirrors and dependencies for NextDNS
#sudo wget -qO /usr/share/keyrings/nextdns.gpg https://repo.nextdns.io/nextdns.gpg
#echo "deb [signed-by=/usr/share/keyrings/nextdns.gpg] https://repo.nextdns.io/deb stable main" | sudo tee /etc/apt/sources.list.d/nextdns.list

# Section - 12 | Purpose - Update repo mirrors & install Brave, LibreWolf and VSCodium | Linked Resources - 
## Update repo mirrors
#nala fetch --auto -y 
#nala update 
#nala upgrade -y 
## Install Brave, LibreWolf and VSCodium
#nala install -y brave-browser
#nala install -y librewolf
#nala install -y codium
#nala install -y nextdns

# Section - 13 | Purpose - Add Bitwarden, Joplin, and KDE Plasma Extension to Brave | # Linked Resources
## Creates path to place extensions
#EXTENSIONS_PATH=/opt/brave.com/brave/extensions
#mkdir -p $EXTENSIONS_PATH
#
#BITWARDEN_ID=nngceckbapebfimnlniiiahkandclblb
#echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${BITWARDEN_ID}.json"
#
#KDE_ID=cimiefiiaegbelhefglklhhakcgmhkai
#echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${KDE_ID}.json"
#
#JOPLIN_ID=alofnhikmmkdbbbgpnglcpdollgjjfek
#echo '{ "external_update_url": "https://clients2.google.com/service/update2/crx" }' > "${EXTENSIONS_PATH}/${JOPLIN_ID}.json"

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

# Section - 15 | Purpose - Install Torguard | Linked Resources - 
#sudo wget  https://updates.torguard.biz/Software/Linux/torguard-latest-amd64.deb
#dpkg -i torguard-latest.amd64.deb

# Section - 16 | Purpose - Install docker and run Portainer container | Linked resources -
### Add Dockers official GPG key:
#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#sudo chmod a+r /etc/apt/keyrings/docker.gpg
### Use the following command to set up the repository:
#echo \
#  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
#  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
#  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
### Update apt (nala):
#nala update 
### To install the latest version, run:
#nala install -y docker-ce
#nala install -y docker-ce-cli
#nala install -y containerd.io
#nala install -y docker-buildx-plugin
#nala install -y docker-compose-plugin
### Run Portainer container:
#docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest


# Section - 15 | Purpose - Install QEMU/KVM | Linked Resources: https://christitus.com/vm-setup-in-linux/
#
#nala install -y qemu-kvm 
#nala install -y qemu-system
#nala install -y qemu-utils
#nala install -y python3
#nala install -y python3-pip
#nala install -y libvirt-clients
#nala install -y libvirt-daemon-system
#nala install -y bridge-utils 
#nala install -y virtinst
#nala install -y libvirt-daemon
#nala install -y virt-manager

#systemctl enable --now libvirtd
#virsh net-start default
#virsh net-autostart default


#########################################
########## SECTION 99  - START ##########
#########################################
#
# Putpose - This section is to track processes that need to be added. 
#
# 1 - Correct method for performing Joplin install to us any account and not just sean
# 2 - Include configuration options for NextDNS
# 3 - Include anymore Brave extensions (ad blocker)
# 4 - Apply favorite wallpaper - https://store.kde.org/p/1370727
#
#
#
# NextDNS Configuration commands
# sudo nextdns install \
# -profile <your profile id> \
# -report-client-info \
# -auto-activate
