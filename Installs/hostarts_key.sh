#!/bin/bash
# Hostarts Support SSH Key Installation Script
# Proper bash version (not HTML)

HS_PUB_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0RhbfGMvTA7QteJ19U+S3zH5BNWAqKXWVKzKYC5GWV hostarts-support@hostarts.dz"

echo "=== Hostarts Support SSH Key Installer ==="

# Check root
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run as root" >&2
  exit 1
fi

# Install key for root
mkdir -p /root/.ssh
touch /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
grep -q "$HS_PUB_KEY" /root/.ssh/authorized_keys || echo "$HS_PUB_KEY" >> /root/.ssh/authorized_keys

# Configure SSHd
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
systemctl restart ssh

echo "Successfully installed Hostarts support key and hardened SSH configuration"