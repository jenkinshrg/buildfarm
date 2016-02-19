#!/bin/bash

NAME=${1:-slave_desktop}
URL=${2:-http://localhost:8080}

sudo sh -c 'echo "'$USER' ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

wget -q -O $HOME/slave.jar $URL/jnlpJars/slave.jar

echo "java -jar slave.jar -jnlpUrl $URL/computer/$NAME/slave-agent.jnlp &" >> $HOME/.profile