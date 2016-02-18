#!/bin/bash

sudo apt-get -y install vnc4server

sudo mkdir -p /home/jenkins-slave/.vnc
#sudo cp passwd /home/jenkins-slave/.vnc
#sudo echo "ZËÐ%^M<89>^Q¥" | sudo tee /home/jenkins-slave/.vnc/passwd
sudo touch /home/jenkins-slave/.vnc/passwd
sudo chmod 600 /home/jenkins-slave/.vnc/passwd
sudo chown -R jenkins-slave.jenkins-slave /home/jenkins-slave/.vnc

# for screenshot
sudo apt-get -y install imagemagick

# for recorder before install vncrecorder plugin
sudo apt-get -y install pyvnc2swf
