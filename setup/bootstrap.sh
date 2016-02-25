#!/bin/bash

sudo sh -c 'echo Asia/Tokyo > /etc/timezone'
sudo dpkg-reconfigure --frontend noninteractive tzdata

sudo sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://ftp.jaist.ac.jp/pub/Linux/ubuntu@g" /etc/apt/sources.list
sudo apt-get update
sudo apt-get dist-upgrade

sudo apt-get -y install git

if [ -f /home/anonymous/.gitconfig ]; then
  cp /home/anonymous/.gitconfig /home/vagrant
fi
if [ -f /home/anonymous/.git-credentials ]; then
  cp /home/anonymous/.git-credentials /home/vagrant
fi
if [ -d /home/anonymous/.ssh ]; then
  cp -r /home/anonymous/.ssh /home/vagrant
fi
if [ -d /home/anonymous/.jenkinshrg ]; then
  cp -r /home/anonymous/.jenkinshrg /home/vagrant
fi
