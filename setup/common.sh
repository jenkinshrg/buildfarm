#!/bin/bash

sudo sh -c 'echo Asia/Tokyo > /etc/timezone'
sudo dpkg-reconfigure --frontend noninteractive tzdata

sudo sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://ftp.jaist.ac.jp/pub/Linux/ubuntu@g" /etc/apt/sources.list
sudo sed -i -e 's/http.debian.net/ftp.jp.debian.org/g' /etc/apt/sources.list
sudo apt-get update

sudo apt-get -y install software-properties-common
sudo apt-get -y install python-software-properties

sudo apt-get -y install subversion
sudo apt-get -y install git

sudo apt-get -y install build-essential

sudo apt-get -y install openjdk-7-jdk

sudo apt-get -y install python python-dev python-pip

sudo apt-get -y install cmake

sudo apt-get -y install libgtest-dev
sudo apt-get -y install lcov
sudo sed -i -e 's/lcov_branch_coverage = 0/lcov_branch_coverage = 1/g' /etc/lcovrc 
sudo pip install lcov_cobertura

#sudo pip install unittest-xml-reporting
#sudo pip install coverage
#sudo pip install nose

sudo apt-get -y install xautomation imagemagick recordmydesktop
sudo apt-get -y install valgrind kcachegrind
sudo apt-get -y install cppcheck
#sudo apt-get -y install cccc

sudo pip install google-api-python-client

sudo apt-get -y install phantomjs
sudo pip install selenium

#sudo pip install python-jenkins
