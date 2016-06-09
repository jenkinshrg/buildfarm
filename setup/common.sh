#!/bin/bash

sudo apt-get update

sudo apt-get -y install daemon
sudo apt-get -y install openjdk-7-jdk

sudo apt-get -y install unattended-upgrades
cat << EOF | sudo tee /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF

sudo apt-get -y install debootstrap
sudo apt-get -y install debian-archive-keyring
sudo apt-get -y install nfs-common

wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo sh -c 'echo "DOCKER_OPTS=\"--dns=150.29.246.19 --dns=150.29.254.121\"" >> /etc/default/docker'
sudo service docker restart
