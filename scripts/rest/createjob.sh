#!/bin/bash

NAME=${1}
URL=${2:-http://localhost:8080}

cat << EOL | curl ${URL}/createItem?name=${NAME} -X POST --user akira-tokunaga:74475a159e15e7dd6e9dce4607425873 -H "Content-Type: text/xml" -d @-
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders/>
  <publishers/>
  <buildWrappers/>
</project>
EOL
