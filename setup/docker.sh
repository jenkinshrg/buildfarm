#!/bin/bash

wget -qO- https://get.docker.com/ | sh

sudo sh -c 'echo "DOCKER_OPTS=\"--dns=150.29.246.19 --dns=150.29.254.121\"" >> /etc/default/docker'
sudo service docker restart

sudo usermod -aG docker $USER
#sudo su - $USER
