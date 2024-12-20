#1 /usr/bin/sh 
flatpak update -y --noninteractive
sudo zypper -n dup
# Check if a reboot is needed
if zypper needs-rebooting; then
    echo "A system reboot is required."
    reboot
else
    echo "Update completed. No reboot required."
fi