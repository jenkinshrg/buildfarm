#!/bin/bash

wget -qO- https://get.docker.com/ | sh
#sudo usermod -aG docker $USER
#sudo su - $USER

sudo apt-get -y install debootstrap

rm -fr docker
git clone --depth 1 https://github.com/docker/docker.git
cd docker/contrib

if [ "$(sudo docker images -q base/debian:wheezy)" = "" ]; then
sudo ./mkimage.sh -t base/debian:wheezy debootstrap --verbose --variant=minbase --include=iproute,iputils-ping,sudo --components=main,restricted,universe,multiverse --arch=i386 wheezy http://ftp.jp.debian.org/debian
fi

if [ "$(sudo docker images -q jenkinshrg/debian:wheezy)" = "" ]; then
cat << EOL | sudo docker build -t jenkinshrg/debian:wheezy -
FROM base/debian:wheezy
RUN sudo useradd -m -d /home/docker -s /bin/bash docker
RUN sudo sh -c 'echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
USER docker
WORKDIR /home/docker
ENV USER docker
ENV HOME /home/docker
ENV DEBIAN_FRONTEND noninteractive
EOL
fi

if [ "$(sudo docker images -q base/ubuntu:trusty)" = "" ]; then
sudo ./mkimage.sh -t base/ubuntu:trusty debootstrap --verbose --variant=minbase --include=iproute,iputils-ping,sudo --components=main,restricted,universe,multiverse --arch=amd64 trusty http://ftp.jaist.ac.jp/pub/Linux/ubuntu
fi

if [ "$(sudo docker images -q jenkinshrg/ubuntu:trusty)" = "" ]; then
cat << EOL | sudo docker build -t jenkinshrg/ubuntu:trusty -
FROM base/ubuntu:trusty
RUN sudo useradd -m -d /home/docker -s /bin/bash docker
RUN sudo sh -c 'echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
USER docker
WORKDIR /home/docker
ENV USER docker
ENV HOME /home/docker
ENV DEBIAN_FRONTEND noninteractive
EOL
fi

cd ../..
rm -fr docker
