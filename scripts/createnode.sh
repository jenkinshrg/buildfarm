#!/bin/bash

NAME=${1}
RFS=${2:-$HOME}
URL=${3:-http://localhost:8080}

wget -q $URL/jnlpJars/jenkins-cli.jar
cat << EOL | java -jar jenkins-cli.jar -s $URL create-node $NAME
<?xml version="1.0" encoding="UTF-8"?>
<slave>
  <name>$NAME</name>
  <description></description>
  <remoteFS>$RFS</remoteFS>
  <numExecutors>1</numExecutors>
  <mode>EXCLUSIVE</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <label></label>
  <nodeProperties/>
  <userId>anonymous</userId>
</slave>
EOL
rm jenkins-cli.jar
