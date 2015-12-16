#!/bin/bash

sudo sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://ftp.jaist.ac.jp/pub/Linux/ubuntu@g" /etc/apt/sources.list

sudo sed -i -e 's/http.debian.net/ftp.jp.debian.org/g' /etc/apt/sources.list

sudo apt-get update

sudo sh -c 'echo Asia/Tokyo > /etc/timezone'
sudo dpkg-reconfigure --frontend noninteractive tzdata

sudo apt-get -y install software-properties-common
sudo apt-get -y install python-software-properties

sudo apt-get -y install subversion
sudo apt-get -y install git
