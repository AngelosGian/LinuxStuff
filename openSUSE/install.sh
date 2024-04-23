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

zypper ref
zypper up
zypper dup

zypper in neofetch shotwell kitty picom


cd $builddir

mkdir -p /home/$username/.fonts
mkdir -p /home/$username/.themes
mkdir -p /home/$username/.config
mkdir -p /home/$username/Github

cd ~/Downloads
git clone https://github.com/EliverLara/Sweet.git
cd ../Github


cd $builddir 
#rename the default bashrc file
mv /home/$username/.bashrc /home/$username/bashrc.bak

#copying the configuration file for sway and the bashrc
cp -r /home/$username/variousettings/debian-sway/.config/* /home/$username/.config
cp  /home/$username/variousettings/debian-sway/bashrc /home/$username/
mv  /home/$username/bashrc /home/$username/.bashrc
cp -r /home/$username/GitHub/Sweet/ /home/$username/.themes/


echo "done"


