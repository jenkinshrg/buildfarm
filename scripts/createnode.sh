#!/bin/bash

if [ $# -lt 1 ] ;  then
  echo "Usage:" $0 "nodename"
  exit
fi

NAME=$1
NUMEXECUTORS=$2

URL=http://jenkinshrg.a01.aist.go.jp

wget -q $URL/jnlpJars/jenkins-cli.jar
cat << EOL | java -jar jenkins-cli.jar -s $URL create-node $NAME
<?xml version="1.0" encoding="UTF-8"?>
<slave>
  <name>$NAME</name>
  <description></description>
  <remoteFS>$HOME</remoteFS>
  <numExecutors>$NUMEXECUTORS</numExecutors>
  <mode>EXCLUSIVE</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <label></label>
  <nodeProperties/>
  <userId>anonymous</userId>
</slave>
EOL
rm jenkins-cli.jar
