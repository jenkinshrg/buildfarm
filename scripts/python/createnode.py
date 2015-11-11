#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import jenkins

name = sys.argv[1]
if len(sys.argv) > 2:
    rfs = sys.argv[2]
else:
    rfs = os.environ.get("HOME")
if len(sys.argv) > 3:
    url = sys.argv[3]
else:
    url = "http://localhost:8080"

numExecutors = 1
nodeDescription  = None
remoteFS = rfs
labels = None
exclusive = True
launcher = 'hudson.slaves.JNLPLauncher'
launcher_params = {}

j = jenkins.Jenkins(url)

j.create_node(name, numExecutors, nodeDescription, remoteFS, labels, exclusive, launcher, launcher_params)
