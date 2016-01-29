#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse
import jenkins
import os

parser = argparse.ArgumentParser()
parser.add_argument('--url', default='http://localhost:8080')
parser.add_argument('--username')
parser.add_argument('--password')
parser.add_argument('--rfs', default=os.environ.get("HOME"))
parser.add_argument('name')
args = parser.parse_args()
url = args.url
username = args.username
password = args.password
rfs = args.rfs
name = args.name

j = jenkins.Jenkins(url, username, password)

numExecutors = 1
nodeDescription  = None
remoteFS = rfs
labels = None
exclusive = True
launcher = 'hudson.slaves.JNLPLauncher'
launcher_params = {}

j.create_node(name, numExecutors, nodeDescription, remoteFS, labels, exclusive, launcher, launcher_params)
