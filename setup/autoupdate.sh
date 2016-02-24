#!/bin/bash

sudo apt-get update
sudo apt-get -y install unattended-upgrades

#sudo dpkg-reconfigure -plow unattended-upgrades
cat << EOF | sudo tee /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF

#sudo sh -c 'echo "Unattended-Upgrade::Automatic-Reboot "false";" >> /etc/apt/apt.conf.d/50unattended-upgrades'
#sudo sh -c 'echo "Unattended-Upgrade::Automatic-Reboot-Time "02:00";" >> /etc/apt/apt.conf.d/50unattended-upgrades'
