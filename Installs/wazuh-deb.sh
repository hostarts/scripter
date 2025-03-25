#!/bin/bash

# Exit if no IP provided
if [ -z "$1" ]; then
  echo "Usage: bash <(curl -s https://key.hostarts.com/wazuh.sh) <WAZUH_MANAGER_IP>"
  exit 1
fi

WAZUH_MANAGER="$1"

# Download the Wazuh agent package
wget -q https://packages.wazuh.com/4.x/apt/pool/main/w/wazuh-agent/wazuh-agent_4.7.5-1_amd64.deb -O /tmp/wazuh-agent.deb

# Install the agent with the manager IP
WAZUH_MANAGER="$WAZUH_MANAGER" dpkg -i /tmp/wazuh-agent.deb

# Reload and enable the service
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent
