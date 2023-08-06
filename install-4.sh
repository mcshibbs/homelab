#!/bin/bash

# Section - 01 | Purpose - Check if script is Run as Root | Linked Resources - N/A
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

# Section - 15 | Purpose - Install Torguard | Linked Resources - 
#sudo wget  https://updates.torguard.biz/Software/Linux/torguard-latest-amd64.deb
#dpkg -i torguard-latest.amd64.deb

# Section - 16 | Purpose - Install docker and run Portainer container | Linked resources -
### Add Dockers official GPG key:
sudo install -m 0755 -d /etc/apt/keyrings
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