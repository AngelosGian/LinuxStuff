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

apt update
apt upgrade -y

apt install nala git neofetch -y
nala install -y build-essential cmake cmake-extras curl gettext libnotify-bin light meson ninja-build libxcb-util0-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-cursor-dev libxcb-xinerama0-dev libstartup-notification0-dev
nala install sway swaybg swayidle swayimg swaylock waybar wofi fonts-font-awesome -y
nala install -y thunar thunar-archive-plugin thunar-volman file-roller
nala install -y dunst unzip xdotool libnotify-dev
nala install --no-install-recommends -y sddm
#sudo systemctl enable sddm

cd $builddir

mkdir -p /home/$username/.config
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/GitHub
cd ~/GitHub
git clone https://github.com/EliverLara/Sweet.git

cd $builddir 


#copying the configuration file for sway and the bashrc
#cp -r /home/$username/LinuxStuff/debian-sway/.config/* /home/$username/.config
\cp  /home/$username/LinuxStuff/debian-sway/bashrc ~
mv  /home/$username/bashrc /home/$username/.bashrc
cp -r /home/$username/GitHub/Sweet/ /usr/share/themes/


echo "done"


