#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to show an animated progress bar
progress() {
    duration=$1
    interval=1  # Ensure integer-based delay
    steps=$((duration / interval))
    for ((i=0; i<steps; i++)); do
        echo -ne "${YELLOW}Processing${NC} ${GREEN}["
        for ((j=0; j<i%10; j++)); do echo -ne "="; done
        echo -ne ">"
        for ((j=i%10; j<9; j++)); do echo -ne " "; done
        echo -ne "]\r"
        sleep $interval
    done
    echo -e "\n"
}

# Function to check if Email Security is installed
check_installed() {
    plesk bin extension --list | grep -q 'email-security'
}

echo -e "${GREEN}"
echo "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo "┃  HOSTARTS | Houssam Chergui       ┃"
echo "┃  Fix Plesk Mail Security Script  ┃"
echo "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
echo -e "${NC}"

# Step 2: Uninstall Plesk Email Security (if installed)
if check_installed; then
    echo -e "${YELLOW}Uninstalling Plesk Email Security...${NC}"
    plesk bin extension --uninstall email-security > /dev/null 2>&1 &
    progress 5

    # Verify uninstallation
    if check_installed; then
        echo -e "${RED}❌ Failed to uninstall Email Security!${NC}"
    else
        echo -e "${GREEN}✅ Email Security successfully uninstalled.${NC}"
        
        # Step 3: Reinstall Plesk Email Security
        echo -e "${YELLOW}Reinstalling Plesk Email Security...${NC}"
        plesk bin extension --install email-security > /dev/null 2>&1 &
        progress 8

        # Verify reinstallation
        if check_installed; then
            echo -e "${GREEN}✅ Email Security successfully reinstalled!${NC}"
        else
            echo -e "${RED}❌ Failed to reinstall Email Security!${NC}"
        fi
    fi
else
    echo -e "${YELLOW}ℹ️  Plesk Email Security is not installed. Skipping uninstallation & reinstallation.${NC}"
fi

# Step 4: Fix Mail Services
echo -e "${YELLOW}Running mail service fixes...${NC}"

# Rebuild mail configuration without spam filtering
plesk sbin mchk --without-spam > /dev/null 2>&1 &
progress 5
echo -e "${GREEN}✅ Mail configuration rebuilt.${NC}"

# Restart Postfix
echo -e "${YELLOW}Restarting Postfix...${NC}"
service postfix restart > /dev/null 2>&1 &
progress 3
echo -e "${GREEN}✅ Postfix restarted.${NC}"

# Requeue all mails
echo -e "${YELLOW}Reprocessing all queued emails...${NC}"
postsuper -r ALL > /dev/null 2>&1 &
progress 3
echo -e "${GREEN}✅ All queued emails have been reprocessed.${NC}"

# Final Message
echo -e "${GREEN}🎉 Your mail should be fixed!${NC}"
echo -e "Made by ${YELLOW}Houssam Chergui | HOSTARTS${NC} 🚀"

exit 0