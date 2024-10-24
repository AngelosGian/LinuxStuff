#1 /usr/bin/sh 

sudo zypper -n dup
# Check if a reboot is needed
if [ -f /var/run/reboot-required ]; then
    echo "A system reboot is required."
else
    echo "Update completed. No reboot required."
fi