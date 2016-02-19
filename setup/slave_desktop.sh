#!/bin/bash

NAME=${1:-$(hostname)}
URL=${2:-http://jenkinshrg.a01.aist.go.jp}

sudo apt-get -y install openjdk-7-jdk

sudo apt-get -y install git

sudo sh -c 'echo "'$USER' ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

wget -q -O $HOME/slave.jar $URL/jnlpJars/slave.jar
java -jar slave.jar -jnlpUrl $URL/computer/$NAME/slave-agent.jnlp &

echo "java -jar slave.jar -jnlpUrl $URL/computer/$NAME/slave-agent.jnlp &" >> $HOME/.profile
