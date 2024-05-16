#!/bin/sh

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

apt update
apt upgrade -y

apt install -y nala neofetch picom
nala install -y build-essential cmake cmake-extras curl gettext libnotify-bin light meson ninja-build libxcb-util0-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-cursor-dev libxcb-xinerama0-dev libstartup-notification0-dev
#Sway 
nala install -y sway swaybg swayidle swayimg swaylock waybar wofi 
#for notifications
nala install -y swaync 
#or
#nala install dunst 

#Folder Manager
nala install -y thunar thunar-archive-plugin thunar-volman file-roller

nala install -y unzip xdotool libnotify-dev pipewire pavucontrol

#fonts
nala install -y fonts-font-awesome

#display manager
nala install --no-install-recommends -y sddm
sudo systemctl enable sddm

cd $builddir

mkdir -p /home/$username/.config
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Github
cd /home/$username/Downloads
git clone https://github.com/EliverLara/Sweet.git

cd $builddir 


#copying the configuration file for sway and the bashrc
#cp -r /home/$username/LinuxStuff/debian-sway/.config/* /home/$username/.config
cp  /home/$username/LinuxStuff/debian-sway/.bashrc ~
sudo mv /home/$username/Downloads/Sweet/ /usr/share/themes/
sudo cp -r /home/$username/LinuxStuff/.config/* /home/$username/.config

echo "$GREEN done successfully installing $GREEN"


