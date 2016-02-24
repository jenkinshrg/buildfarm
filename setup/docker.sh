#!/bin/bash

sudo apt-get -y install debootstrap

sudo apt-get -y install debian-archive-keyring
#sudo apt-get -y install ubuntu-archive-keyring

wget -qO- https://get.docker.com/ | sh

sudo sh -c 'echo "DOCKER_OPTS=\"--dns=150.29.246.19 --dns=150.29.254.121\"" >> /etc/default/docker'
sudo service docker restart

sudo usermod -aG docker $USER
#sudo su - $USER
