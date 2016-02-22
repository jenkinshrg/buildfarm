#!/bin/bash

if [ $# -lt 1 ] ;  then
  echo "Usage:" $0 "nodename"
  exit
fi

NAME=${1}

URL=http://jenkinshrg.a01.aist.go.jp

wget -q $URL/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s $URL delete-node $NAME
rm jenkins-cli.jar
