#!/bin/bash

NAME=${1-debug}
REPO_URL=${2-https://github.com/jenkinshrg/drcutil.git}
REPO_DIR=${3-drcutil}
BRANCH=${4-jenkins}
NODE=${5-master}
OS=${6-ubuntu}
DISTRO=${7-trusty}
ARCH=${8-amd64}
TRIGGER=${9-none}
FUNC=${10-build}
TEST=${11-all}
URL=${12:-http://localhost:8080}

JOB_NAME=$NAME
WORKSPACE=$HOME/workspace/$JOB_NAME

if [ "$OS" = "debian" ]; then
MIRROR=http://ftp.jp.debian.org/debian/
COMPONENTS=main,contrib,non-free
INCLUDE=iproute,iputils-ping,sudo
elif [ "$OS" = "ubuntu" ]; then
MIRROR=http://ftp.jaist.ac.jp/pub/Linux/ubuntu/
COMPONENTS=main,restricted,universe,multiverse
INCLUDE=iproute,iputils-ping,sudo
fi

if [ "$(sudo docker images -q base/$OS:$DISTRO)" = "" ]; then
rm -fr docker
git clone --depth 1 https://github.com/docker/docker.git
cd docker/contrib
sudo ./mkimage.sh -t base/$OS:$DISTRO debootstrap --verbose --variant=buildd --include=$INCLUDE --components=$COMPONENTS --arch=$ARCH $DISTRO $MIRROR
cd ../..
rm -fr docker
fi

if [ "$(sudo docker images -q original/$OS:$DISTRO)" = "" ]; then
cat << EOL | sudo docker build -t original/$OS:$DISTRO -
FROM base/$OS:$DISTRO
RUN sudo useradd -m -d /home/docker -s /bin/bash docker
RUN sudo sh -c 'echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
USER docker
WORKDIR /home/docker
ENV USER docker
ENV HOME /home/docker
ENV DEBIAN_FRONTEND noninteractive
EOL
fi

mkdir -p $WORKSPACE
cd $WORKSPACE

rm -fr src
rm -fr openrtp
rm -fr $REPO_DIR
git clone --branch $BRANCH --single-branch $REPO_URL $REPO_DIR
sudo docker run --rm -t -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -e JOB_NAME=$JOB_NAME -e WORKSPACE=/home/docker/workspace -v $WORKSPACE:/home/docker/workspace -w /home/docker/workspace -v $HOME/.jenkinshrg:/home/docker/.jenkinshrg --dns=150.29.246.19 --dns=150.29.254.121 original/$OS:$DISTRO /bin/bash -c "$(cat << EOL
set -xe
/home/docker/.jenkinshrg/install/credential.sh
cd $REPO_DIR
source .jenkins.sh $FUNC $TEST
EOL
)"
