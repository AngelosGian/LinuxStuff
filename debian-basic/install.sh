#!/bin/bash

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'


# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt-get update
apt-get upgrade -y
apt-get install -y nala git


# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/GitHub


chown -R $username:$username /home/$username

# Install nala


# Installing Essential Programs 
nala install -y shotwell kitty picom lxpolkit x11-xserver-utils unzip wget curl pulseaudio pavucontrol build-essential libx11-dev libxft-dev libxinerama-dev
# Installing Other less important Programs
nala install -y neofetch psmisc mangohud kate lxappearance fonts-noto-color-emoji -y

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Sweet.git

# Installing fonts
cd $builddir 
nala install fonts-font-awesome -y

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.1/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.1/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts

chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip ./Meslo.zip



installStarship(){
    if command_exists starship; then
        echo "Starship already installed"
        return
    fi

    if ! curl -sS https://starship.rs/install.sh|sh;then
        echo -e "${RED}Something went wrong during starship install!${RC}"
        exit 1
    fi
}






# Use nala
#bash scripts/usenala