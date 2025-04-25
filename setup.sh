#!/bin/bash

# Define the script and service names
SCRIPT_NAME="wsl2host.sh"
SERVICE_NAME="wsl2host.service"
SCRIPT_PATH="/usr/local/share/wsl2host/$SCRIPT_NAME"

# Create the service file
sudo bash -c "cat > /etc/systemd/system/$SERVICE_NAME << EOF
[Unit]
Description=Update Windows Hosts File
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=$SCRIPT_PATH

[Install]
WantedBy=multi-user.target
EOF"

# Create the script directory
sudo mkdir -p /usr/local/share/wsl2host

# Copy the script and make it executable
sudo cp $SCRIPT_NAME $SCRIPT_PATH
sudo chmod +x $SCRIPT_PATH

# Enable and start the service
sudo systemctl enable --now $SERVICE_NAME

echo "The $SCRIPT_NAME script and $SERVICE_NAME service have been installed and set up."
