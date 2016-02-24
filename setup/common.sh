#!/bin/bash

sudo apt-get -y install openjdk-7-jdk

sudo apt-get -y install git
git config --global user.email "jenkinshrg@gmail.com"
git config --global user.name "jenkinshrg"
git config --global credential.helper store
git config --global http.sslVerify false

sudo apt-get -y install unattended-upgrades
#sudo dpkg-reconfigure -plow unattended-upgrades
cat << EOF | sudo tee /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF
