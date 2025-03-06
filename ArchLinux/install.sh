#!/bin/bash

# Define colors for better readability
RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

# Function to print colored messages
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${RC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  print_message "$RED" "You must be a root user to run this script, please run sudo ./install.sh"
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
print_message "$GREEN" "Updating system packages..."
apt-get update
apt-get upgrade -y
apt-get install -y nala git
nala fetch --auto
nala update

# Define package arrays
ESSENTIAL_PACKAGES=(
    build-essential
    shotwell
    kitty
    picom
    lxpolkit
    zip
    unzip
    wget
    curl
    pipewire
    pavucontrol
    libx11-dev
    libxft-dev
    libxinerama-dev
    x11-xserver-utils
)

EXTRA_PACKAGES=(
    fastfetch
    psmisc
    mangohud
    lxappearance
    fonts-noto-color-emoji
    fonts-font-awesome
)

# Create necessary directories
print_message "$GREEN" "Creating necessary directories..."
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/GitHub

chown -R $username:$username /home/$username

# Installing packages
print_message "$GREEN" "Installing essential packages..."
nala install -y "${ESSENTIAL_PACKAGES[@]}"

print_message "$GREEN" "Installing extra packages..."
nala install -y "${EXTRA_PACKAGES[@]}"

# Download and install themes
print_message "$GREEN" "Installing themes..."
cd /usr/share/themes/
if [ ! -d "Sweet" ]; then
    git clone https://github.com/EliverLara/Sweet.git
else
    print_message "$YELLOW" "Sweet theme already installed"
fi

# Installing fonts
print_message "$GREEN" "Installing fonts..."
cd $builddir 

# Download and install Nerd Fonts
install_nerd_font() {
    local font_name=$1
    local font_file="${font_name}.zip"
    
    if [ ! -f "$font_file" ]; then
        print_message "$GREEN" "Downloading ${font_name} font..."
        wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.1/${font_file}"
    fi
    
    print_message "$GREEN" "Installing ${font_name} font..."
    unzip -o "$font_file" -d /home/$username/.fonts
    rm -f "$font_file"
}

install_nerd_font "FiraCode"
install_nerd_font "Meslo"

chown $username:$username /home/$username/.fonts/*

# Reload font cache
print_message "$GREEN" "Reloading font cache..."
fc-cache -vf

# Install Starship prompt
installStarship() {
    if command_exists starship; then
        print_message "$YELLOW" "Starship already installed"
        return
    fi

    print_message "$GREEN" "Installing Starship prompt..."
    if ! curl -sS https://starship.rs/install.sh | sh; then
        print_message "$RED" "Something went wrong during starship install!"
        exit 1
    fi
    
    # Add starship to .bashrc if not already there
    if ! grep -q "eval \"\$(starship init bash)\"" /home/$username/.bashrc; then
        echo 'eval "$(starship init bash)"' >> /home/$username/.bashrc
    fi
}

installStarship

print_message "$GREEN" "Installation completed successfully!"