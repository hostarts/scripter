#!/bin/bash

# ==================================================================
# 🏆  Hardware Info Script - v1.0
# 📌 Author: Houssam Chergui
# 📅 Date: $(date +"%Y-%m-%d")
# 📜 License: MIT
# 🌐 Website: https://hostarts.dz
# 📢 Description: Collects full system hardware details on servers
# 🔥 Inspired by YABS, but for hardware analysis!
# ==================================================================

(
echo "===== 🖥️ System Information ====="
hostnamectl

echo; echo "===== 🏗️ Motherboard Details ====="
dmidecode -t baseboard | grep -E "Manufacturer|Product Name|Version|Serial Number"

echo; echo "===== 🔥 CPU Information ====="
lscpu | grep -E "Model name|Socket|CPU\(s\)|Thread|MHz|NUMA"

echo; echo "===== 🧠 RAM Details ====="
dmidecode -t memory | grep -E "Manufacturer:|Part Number:|Size:|Speed:"

echo; echo "===== 💾 Storage Devices ====="
lsblk -o NAME,MODEL,VENDOR,TYPE,SIZE,ROTA,TRAN

echo; echo "===== 🚀 NVMe Drives ====="
nvme list 2>/dev/null || echo "No NVMe drives found"

echo; echo "===== 🎛️ RAID Controllers (if any) ====="
lspci | grep -i raid || echo "No RAID controller detected"

echo; echo "===== 🌐 Network Interfaces ====="
ip -brief address

echo; echo "===== 📡 Active Network Interfaces ====="
lspci | grep -i net
) | tee hardware-report.txt