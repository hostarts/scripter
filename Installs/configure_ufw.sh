#!/bin/bash
# UFW Firewall Configuration Script
# Usage: sudo ./configure_ufw.sh

# Define allowed IPs
JUMP_SERVER_IP="95.216.199.251"  # Your jump server IP

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run as root" >&2
  exit 1
fi

# Function to install UFW
install_ufw() {
  echo "Installing UFW firewall..."
  if command -v apt-get &> /dev/null; then
    apt-get update
    apt-get install -y ufw
  elif command -v yum &> /dev/null; then
    yum install -y ufw
  elif command -v dnf &> /dev/null; then
    dnf install -y ufw
  else
    echo "Error: Could not detect package manager to install UFW" >&2
    exit 1
  fi
  
  # Verify installation
  if ! command -v ufw &> /dev/null; then
    echo "Error: UFW installation failed" >&2
    exit 1
  fi
  echo "UFW successfully installed"
}

# Main configuration function
configure_firewall() {
  echo "Configuring firewall rules..."
  
  # Reset and enable UFW
  ufw --force reset
  echo "y" | ufw enable

  # Default policies
  ufw default deny incoming
  ufw default allow outgoing

  # SSH Access (Restricted to jump server)
  ufw allow from $JUMP_SERVER_IP to any port 22 proto tcp

  # Web Services
  ufw allow 80/tcp
  ufw allow 443/tcp

  # Email Services
  ufw allow 25/tcp     # SMTP
  ufw allow 465/tcp    # SMTPS
  ufw allow 587/tcp    # Submission
  ufw allow 143/tcp    # IMAP
  ufw allow 993/tcp    # IMAPS
  ufw allow 110/tcp    # POP3
  ufw allow 995/tcp    # POP3S

  # DNS
  ufw allow 53/tcp
  ufw allow 53/udp

  # ISPmanager
  ufw allow 1500/tcp

  # Enable all rules
  echo "y" | ufw enable
}

# Check if UFW is installed
if ! command -v ufw &> /dev/null; then
  install_ufw
fi

# Configure firewall
configure_firewall

# Display results
echo -e "\n\033[1mUFW Firewall Rules Configured:\033[0m"
ufw status numbered

echo -e "\n\033[32mFirewall configuration completed successfully!\033[0m"
echo "Note: SSH is only allowed from $JUMP_SERVER_IP"
