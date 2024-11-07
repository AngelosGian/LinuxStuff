#!/bin/bash

# Check if IP address is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

# Define the directory and IP address
SYS_DIRECTORY="/var/www/vhosts/system/"
IP_ADDRESS="$1"

# Search for the IP address in the directory
grep -r --exclude="*.gz" "$IP_ADDRESS" "$SYS_DIRECTORY"
