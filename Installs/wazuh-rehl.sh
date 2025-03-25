#!/bin/bash

# Exit if no IP provided
if [ -z "$1" ]; then
  echo "Usage: bash <(curl -s https://key.hostarts.com/wazuh-rhel.sh) <WAZUH_MANAGER_IP>"
  exit 1
fi

WAZUH_MANAGER="$1"

# Import the Wazuh GPG key and add the repository
cat > /etc/yum.repos.d/wazuh.repo << EOF
[wazuh]
gpgcheck=1
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH
enabled=1
name=Wazuh repository
baseurl=https://packages.wazuh.com/4.x/yum/
protect=1
EOF

# Install the agent
yum install -y wazuh-agent

# Set the Wazuh manager IP
sed -i "s/<address>.*<\/address>/<address>${WAZUH_MANAGER}<\/address>/" /var/ossec/etc/ossec.conf

# Enable and start the service
systemctl daemon-reexec
systemctl enable wazuh-agent
systemctl start wazuh-agent