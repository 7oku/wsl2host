# WSL2 Windows Hosts File Updater

This script automatically updates the Windows hosts file with the current IP address of your WSL2 instance, allowing you to access the WSL2 environment from your Windows host using a custom domain name.

## Features

- Automatically detects the current IP address of the WSL2 instance's `eth0` interface.
- Updates the Windows hosts file with the current IP address and a custom domain name (e.g., `arch.wsl`).
- Handles existing entries in the hosts file, updating the IP address if it has changed.
- Runs as a systemd service, automatically updating the hosts file whenever the network connection changes.

## Installation

1. Clone the repository:

`git clone https://github.com/7oku/wsl2host`

2. Change to the project directory:

`cd wsl2host`

3. Run the setup script:

`sudo ./setup.sh`

This script will:

- Create the `wsl2host.service` systemd service file.
- Copy the `wsl2host.sh` script to `/usr/local/share/wsl2host/`.
- Make the `wsl2host.sh` script executable.
- Enable and start the `wsl2host.service`.

4. That's it! The script will now automatically update the Windows hosts file whenever the network connection changes.

## Customization

You can customize the script by modifying the following variables at the top of the `wsl2host.sh` file:

- `DOMAIN`: The domain name you want to use for your WSL2 instance (e.g., `"arch.wsl"`).

If you need to add or remove domain names, you can update the `DOMAINS` array in the script accordingly.

## Troubleshooting

If you encounter any issues, please check the systemd service logs:

`sudo journalctl -u wsl2host.service`

Make sure that your user account has the necessary permissions to write to the Windows hosts file located at `/mnt/c/Windows/System32/drivers/etc/hosts`.
# wsl2host
