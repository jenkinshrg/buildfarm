#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import jenkins

name = sys.argv[1]
if len(sys.argv) > 2:
    url = sys.argv[2]
else:
    url = "http://localhost:8080"

j = jenkins.Jenkins(url)

print(j.get_job_config(name))
