#!/bin/bash

if [ $# -lt 1 ] ;  then
  echo "Usage:" $0 "nodename"
  exit
fi

NAME=$1

wget -q $JENKINS_URL/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s $JENKINS_URL get-node $NAME
rm jenkins-cli.jar
