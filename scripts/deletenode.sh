#!/bin/bash

if [ $# -lt 1 ] ;  then
  echo "Usage:" $0 "nodename"
  exit
fi

NAME=$1

JENKINS_URL=${JENKINS_URL:-http://jenkinshrg.a01.aist.go.jp}

wget -q $JENKINS_URL/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s $JENKINS_URL delete-node $NAME
rm jenkins-cli.jar
