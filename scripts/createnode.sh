#!/bin/bash

if [ $# -lt 2 ] ;  then
  echo "Usage:" $0 "nodename numexecutors"
  exit
fi

NAME=$1
NUMEXECUTORS=$2

JENKINS_URL=${JENKINS_URL:-http://jenkinshrg.a01.aist.go.jp}
REMOTE_FS=${REMOTE_FS:-$HOME}

wget -q $JENKINS_URL/jnlpJars/jenkins-cli.jar

java -jar jenkins-cli.jar -s $JENKINS_URL login --username jenkinshrg

cat << EOL | java -jar jenkins-cli.jar -s $JENKINS_URL create-node $NAME
<?xml version="1.0" encoding="UTF-8"?>
<slave>
  <name>$NAME</name>
  <description></description>
  <remoteFS>$REMOTE_FS</remoteFS>
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
