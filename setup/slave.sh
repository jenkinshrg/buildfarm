#!/bin/bash

NAME=${1:-slave}
URL=${2:-http://localhost:8080}

wget -q $URL/jnlpJars/slave.jar
java -jar slave.jar -jnlpUrl $URL/computer/$NAME/slave-agent.jnlp &
sleep 1
rm slave.jar
