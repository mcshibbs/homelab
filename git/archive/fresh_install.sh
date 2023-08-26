sudo apt update && sudo apt upgrade -y && sudo apt install -y nala && sudo nala fetch

sudo nala update && sudo nala upgrade -y && sudo nala install -y curl wget gnupg lsb-release apt-transport-https ca-certificates

##Setup for Brave Browser##
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

##Setup for VSCodium##
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
    
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
    
##Setup for LibreWolf##
#
#distro=bookworm
#
#wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
#
#sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
#Types: deb
#URIs: https://deb.librewolf.net
#Suites: $distro
#Components: main
#Architectures: amd64
#Signed-By: /usr/share/keyrings/librewolf.gpg
#EOF

##Install Brave Browser, VSCodium and LibreWolf##
#sudo nala update && sudo nala install codium brave-browser librewolf -y

##This line removes librewolf install 
sudo nala update && sudo nala install codium brave-brwoser -y 

#Install Joplin...The install and update script supports the following flags (around line 50 at the time of this writing).
#https://github.com/laurent22/joplin/blob/dev/Joplin_install_and_update.sh#L50
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

#Nextcloud desktop app from AppImage?