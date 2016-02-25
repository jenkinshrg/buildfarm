#!/bin/bash

if [ $# -lt 1 ] ;  then
  echo "Usage:" $0 "jobname"
  exit
fi

NAME=$1

wget -q $JENKINS_URL/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s $JENKINS_URL build $NAME
rm jenkins-cli.jar
