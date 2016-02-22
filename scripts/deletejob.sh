#!/bin/bash

NAME=${1}

URL=http://jenkinshrg.a01.aist.go.jp

wget -q $URL/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s $URL delete-job $NAME
rm jenkins-cli.jar
