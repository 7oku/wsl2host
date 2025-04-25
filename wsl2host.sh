#!/bin/bash

# Define the domain name
DOMAIN="arch.wsl"

# Define the path to the Windows hosts file
HOSTS_FILE="/mnt/c/Windows/System32/drivers/etc/hosts"

# Get the current IP address of the eth0 interface
IP=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
# Update the hosts file in the Windows System32 directory
if [ -w "$HOSTS_FILE" ]; then
    # Check if the domain already exists in the hosts file
    existing_ip=$(grep -oP "^\s*\d+(\.\d+){3}\s+$DOMAIN" "$HOSTS_FILE")
    if [ -n "$existing_ip" ]; then
        # If the IP address has changed, update the entry
        if [ "$existing_ip" != "$IP $DOMAIN" ]; then
            sudo sed -i "/$DOMAIN/c\\$IP $DOMAIN" "$HOSTS_FILE"
            echo "Updated $DOMAIN to $IP in the Windows hosts file."
        else
            echo "$DOMAIN is already set to $IP in the Windows hosts file."
        fi
    else
        # If the entry doesn't exist, add a new one
        echo "$IP $DOMAIN" | sudo tee -a "$HOSTS_FILE"
        echo "Added $DOMAIN with IP $IP to the Windows hosts file."
    fi
else
    echo "Error: Unable to write to the Windows hosts file."
    exit 1
fi
