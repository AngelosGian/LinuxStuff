#!/bin/bash

# Check if both domain and IP address are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <domain> <IP_ADDRESS>"
  exit 1
fi

# Define variables
DOMAIN="$1"
IP_ADDRESS="$2"
LOG_DIR="/var/www/vhosts/$DOMAIN/logs/"

# Check if the log directory exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Log directory for domain '$DOMAIN' does not exist."
  exit 1
fi

# Search for the IP address in the log files
find "$LOG_DIR" -type f ! -name "*.gz" -exec cat {} + | grep --color=auto "$IP_ADDRESS"