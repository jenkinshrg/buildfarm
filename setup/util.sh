#!/bin/bash

sudo sh -c 'echo "tokunaga ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

LANG=C xdg-user-dirs-gtk-update

sudo add-apt-repository -y ppa:xorg-edgers/ppa
sudo apt-get update
sudo apt-get -y install nvidia-current nvidia-settings
#Change NVIDIA driver
#Enable user auto login
#Disable screen auto off and lock password

sudo apt-get -y install vim
