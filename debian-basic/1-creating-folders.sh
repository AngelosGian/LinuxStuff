#!/bin/bash

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Downloads
mkdir -p /home/$username/Github


chown -R $username:$username /home/$username