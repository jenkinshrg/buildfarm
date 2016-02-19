#!/bin/bash

NAME=${1:-slave_desktop}
URL=${2:-http://localhost:8080}

wget -q -O $HOME/slave.jar $URL/jnlpJars/slave.jar

echo "java -jar slave.jar -jnlpUrl $URL/computer/$NAME/slave-agent.jnlp &" >> $HOME/.profile
