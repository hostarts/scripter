#!/bin/bash
# UFW Firewall Configuration 
# Usage: sudo ./configure_ufw.sh

# Define allowed IPs
JUMP_SERVER_IP="95.216.199.251"  # Your jump server IP

# Reset and enable UFW
ufw --force reset
ufw enable

# Default policies
ufw default deny incoming
ufw default allow outgoing

# 1. SSH Access (Restricted to jump server)
ufw allow from $JUMP_SERVER_IP to any port 22 proto tcp
# Optional: Add office IP for backup access
# ufw allow from $YOUR_OFFICE_IP to any port 22 proto tcp

# 2. Web Services (HTTP/HTTPS)
ufw allow 80/tcp
ufw allow 443/tcp

# 3. Email Services
# SMTP
ufw allow 25/tcp
ufw allow 465/tcp  # SMTPS
ufw allow 587/tcp  # Submission

# IMAP
ufw allow 143/tcp
ufw allow 993/tcp  # IMAPS

# POP3
ufw allow 110/tcp
ufw allow 995/tcp  # POP3S

# 4. Database Access (If needed)
# ufw allow from 192.168.1.100 to any port 3306 proto tcp  # MySQL example

# 5. DNS (If running nameserver)
ufw allow 53/tcp
ufw allow 53/udp

# 6. ISPmanager Control Panel
ufw allow 1500/tcp  # ISPmanager default port

# 7. Monitoring (Optional)
# ufw allow from monitoring.server.ip to any port 5666 proto tcp  # NRPE

# Enable UFW
ufw enable

# Display rules
echo -e "\n\033[1mUFW Firewall Rules Configured:\033[0m"
ufw status numbered

echo -e "\n\033[32mFirewall configuration completed!\033[0m"
echo "Note: SSH is only allowed from $JUMP_SERVER_IP"
