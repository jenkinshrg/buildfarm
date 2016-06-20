#!/bin/bash

jobname=$1
robotname=$2
taskname=$3
autox=$4
autoy=$5
okx=$6
oky=$7
waitsec=$8
targetname=$9
targetport=${10}

./createjob.sh $jobname periodic !master&&!slave1 none none none .jenkins.sh task $robotname $taskname $autox $autoy $okx $oky $waitsec $targetname $targetport
