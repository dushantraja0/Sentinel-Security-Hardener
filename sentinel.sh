#!/bin/bash
# Project: SentinelOps | Developer: Dushant Sharma

echo "--- Sentinel Security Hardening Initialized ---"

# 1. Firewall
sudo ufw default deny incoming > /dev/null
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
echo "y" | sudo ufw enable > /dev/null

# 2. SSH Hardening (Force Fix)
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# 3. Permissions & Audit
sudo chmod 600 /etc/shadow
echo "--- Sentinel Security Audit Report ---" > ~/SecurityProject/audit_report.txt
date >> ~/SecurityProject/audit_report.txt
echo "Active Listeners:" >> ~/SecurityProject/audit_report.txt
ss -tuln | grep LISTEN >> ~/SecurityProject/audit_report.txt

echo "--- Hardening Completed Successfully ---"
