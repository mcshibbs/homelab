#!/bin/bash

# Section - 01 | Purpose - Check if script is Run as Root | Linked Resources - N/A
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Section - 03 | Purpose - Install nala | Linked Resources - N/A
nala update
nala upgrade -y

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


# Section - 16 | Purpose - Install docker and run Portainer container | Linked resources -
### Add Dockers official GPG key:
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
### Use the following command to set up the repository:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
### Update apt (nala):
nala update 
### To install the latest version, run:
nala install -y docker-ce
nala install -y docker-ce-cli
nala install -y containerd.io
nala install -y docker-buildx-plugin
nala install -y docker-compose-plugin
### Run Portainer container:
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest