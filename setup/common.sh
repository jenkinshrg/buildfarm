#!/bin/bash

sudo apt-get update

sudo apt-get -y install daemon

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

sudo apt-get -y install debootstrap

sudo apt-get -y install debian-archive-keyring
#sudo apt-get -y install ubuntu-archive-keyring

wget -qO- https://get.docker.com/ | sh

sudo sh -c 'echo "DOCKER_OPTS=\"--dns=150.29.246.19 --dns=150.29.254.121\"" >> /etc/default/docker'
sudo service docker restart

sudo usermod -aG docker $USER
#sudo su - $USER
