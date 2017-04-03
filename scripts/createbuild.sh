#!/bin/bash

jobname=$1
os=$2
distro=$3
arch=$4

./createjob.sh $jobname upstream slave1 $os $distro $arch .jenkins.sh build
