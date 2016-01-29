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
args = parser.parse_args()
url = args.url
username = args.username
password = args.password
name = args.name

j = jenkins.Jenkins(url, username, password)

print(j.get_job_config(name))
