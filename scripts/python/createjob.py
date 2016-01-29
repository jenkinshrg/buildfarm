#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse
import jenkins

parser = argparse.ArgumentParser()
parser.add_argument('--url', default='http://localhost:8080')
parser.add_argument('--username')
parser.add_argument('--password')
parser.add_argument('name')
#parser.add_argument('repo_url')
#parser.add_argument('repo_dir')
#parser.add_argument('branch')
#parser.add_argument('node')
#parser.add_argument('trigger')
args = parser.parse_args()
url = args.url
username = args.username
password = args.password
name = args.name
#repo_url = args.repo_url
#repo_dir = args.repo_dir
#branch = args.branch
#node = args.node
#trigger = args.trigger

CONFIG_XML = """<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <hudson.plugins.openshift.OpenShiftApplicationUUIDJobProperty plugin="openshift@1.4">
      <applicationUUID></applicationUUID>
    </hudson.plugins.openshift.OpenShiftApplicationUUIDJobProperty>
    <hudson.plugins.openshift.OpenShiftBuilderSizeJobProperty plugin="openshift@1.4">
      <builderSize>small</builderSize>
    </hudson.plugins.openshift.OpenShiftBuilderSizeJobProperty>
    <hudson.plugins.openshift.OpenShiftBuilderTimeoutJobProperty plugin="openshift@1.4">
      <builderTimeout>300000</builderTimeout>
    </hudson.plugins.openshift.OpenShiftBuilderTimeoutJobProperty>
    <hudson.plugins.openshift.OpenShiftBuilderTypeJobProperty plugin="openshift@1.4">
      <builderType></builderType>
    </hudson.plugins.openshift.OpenShiftBuilderTypeJobProperty>
    <hudson.plugins.openshift.OpenShiftPlatformJobProperty plugin="openshift@1.4">
      <platform>linux</platform>
    </hudson.plugins.openshift.OpenShiftPlatformJobProperty>
    <hudson.plugins.openshift.OpenShiftRegionJobProperty plugin="openshift@1.4">
      <region></region>
    </hudson.plugins.openshift.OpenShiftRegionJobProperty>
  </properties>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders/>
  <publishers/>
  <buildWrappers/>
</project>""" % locals()

j = jenkins.Jenkins(url, username, password)

if not j.job_exists(name):
    j.create_job(name, jenkins.EMPTY_CONFIG_XML)

j.reconfig_job(name, CONFIG_XML)
