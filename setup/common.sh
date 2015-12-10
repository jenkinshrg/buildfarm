#!/bin/bash

sudo sed -i -e 's/\/\/jp.archive.ubuntu.com/\/\/ftp.jaist.ac.jp/g' /etc/apt/sources.list
sudo sed -i -e 's/\/\/us.archive.ubuntu.com/\/\/ftp.jaist.ac.jp/g' /etc/apt/sources.list
sudo sed -i -e 's/\/\/archive.ubuntu.com/\/\/ftp.jaist.ac.jp/g' /etc/apt/sources.list
sudo sed -i -e 's/\/\/http.debian.net/\/\/ftp.jp.debian.org/g' /etc/apt/sources.list

sudo apt-get update
#sudo apt-get -y upgrade
#sudo apt-get -y dist-upgrade

sudo apt-get -y install language-pack-ja
sudo update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
#source /etc/default/locale

sudo sh -c 'echo Asia/Tokyo > /etc/timezone'
sudo dpkg-reconfigure --frontend noninteractive tzdata

sudo sed -i -e "s/pc105/jp106/g" /etc/default/keyboard
sudo sed -i -e "s/us/jp/g" /etc/default/keyboard
#source /etc/default/keyboard

sudo apt-get -y install software-properties-common
sudo apt-get -y install python-software-properties

sudo apt-get -y install subversion
sudo apt-get -y install git
