#!/bin/bash

ZABBIX_SERVER_IP="37.27.0.228"

# Détection de la distribution
if [ -f /etc/debian_version ]; then
  echo "➡️ Détection : Debian/Ubuntu"
  apt update -y
  apt install -y zabbix-agent

elif [ -f /etc/redhat-release ]; then
  echo "➡️ Détection : RHEL/CentOS/Rocky/Alma"
  dnf install -y zabbix-agent

else
  echo "❌ Distribution non prise en charge."
  exit 1
fi

# Modification de la configuration
echo "⚙️ Mise à jour de /etc/zabbix/zabbix_agentd.conf"
sed -i "s/^Server=127.0.0.1/Server=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^ServerActive=127.0.0.1/ServerActive=$ZABBIX_SERVER_IP/" /etc/zabbix/zabbix_agentd.conf

# Redémarrage et activation du service
echo "🔁 Redémarrage et activation du service Zabbix Agent"
systemctl restart zabbix-agent
systemctl enable zabbix-agent

echo "✅ Agent Zabbix installé et configuré pour $ZABBIX_SERVER_IP"