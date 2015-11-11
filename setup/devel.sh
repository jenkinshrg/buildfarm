#!/bin/bash

sudo apt-get -y install software-properties-common
sudo apt-get -y install python-software-properties

sudo apt-get -y install build-essential

sudo apt-get -y install python python-dev python-pip

sudo apt-get -y install subversion

sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get -y install git

sudo apt-get -y install sshpass
${HOME}/Documents/jenkinshrg/install/credential.sh

sudo apt-get -y install cmake

sudo apt-get -y install libgtest-dev

sudo apt-get -y install lcov
sudo sed -i -e 's/lcov_branch_coverage = 0/lcov_branch_coverage = 1/g' /etc/lcovrc 
sudo pip install lcov_cobertura

#sudo pip install unittest-xml-reporting
#sudo pip install coverage
#sudo pip install nose

sudo apt-get -y install valgrind kcachegrind

sudo apt-get -y install xautomation imagemagick recordmydesktop

sudo apt-get -y install cppcheck

#sudo apt-get -y install cccc

sudo pip install google-api-python-client

#sudo pip install python-jenkins
