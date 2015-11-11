#!/bin/bash

NAME=${1}
URL=${2:-http://localhost:8080}

wget -q ${URL}/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s ${URL} delete-job ${NAME}
rm jenkins-cli.jar
