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

# Install basic dependencies for Sway WM
apt install -y nala
nala fetch
# Check if expect is installed, and install if necessary
# if ! command -v expect &> /dev/null; then
#     echo "expect not found, installing..."
#     nala install -y expect
# fi

# Use expect to automate nala fetch
# expect <<EOF
# set timeout -1

# # Start the nala fetch process
# spawn nala fetch

# # Define the expected prompt and the response
# expect "Mirrors you want to keep, separated by space or comma (1..16):"
# send "1,2,3\r"

# # Allow the process to complete
# expect eof
# EOF

# # Continue with the rest of your script
# echo "nala fetch completed automatically"

nala install -y build-essential cmake cmake-extras curl glslang-tools libcairo2-dev libcap-dev libdbus-1-dev libdisplay-info-dev libevdev-dev libgdk-pixbuf2.0-dev libinput-dev libjson-c-dev libliftoff-dev libpam0g-dev libpango1.0-dev libpcre2-dev libpixman-1-dev libseat-dev libsystemd-dev libvulkan-dev libwayland-dev libwayland-egl1 libwlroots-dev libxcb-ewmh-dev libxkbcommon-dev meson pkgconf scdoc wayland-protocols

# Install Sway and related tools
nala install -y sway swaybg swayidle swaylock waybar wofi

# Install notification daemon
# nala install -y swaync

# Install file manager
nala install -y thunar thunar-archive-plugin thunar-volman file-roller

# Install additional utilities
nala install -y unzip xdotool libnotify-dev pipewire pavucontrol

# Install fonts
nala install -y fonts-font-awesome

# Install display manager
nala install --no-install-recommends -y sddm
sudo systemctl enable sddm

# Create necessary directories
mkdir -p /home/$username/.config
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Github

# Clone and move theme
cd /home/$username/Downloads
git clone https://github.com/EliverLara/Sweet.git
sudo mv /home/$username/Downloads/Sweet/ /usr/share/themes/

# Copy configuration files
sudo cp -r /home/$username/LinuxStuff/.config/* /home/$username/.config
cp /home/$username/LinuxStuff/debian-sway/.bashrc ~

# Copy evangelion.jpg to the background location
mkdir -p /home/$username/.config/sway
cp /home/$username/LinuxStuff/debian-sway/evangelion.jpg /home/$username/.config/sway/

# Set the background in the Sway config
echo 'output * bg /home/'$username'/.config/sway/evangelion.jpg fill' >> /home/$username/.config/sway/config

echo "$GREEN done successfully installing $GREEN"