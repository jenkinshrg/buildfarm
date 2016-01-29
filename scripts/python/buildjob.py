#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import argparse
import jenkins
#from time import sleep

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

def wait_for_queue(name):
    while True :
        try:
            exists = False
            info = j.get_queue_info()
            for item in info:
                if item['task']['name'] == name:
                    exists = True
            if exists == False:
                return
        except Exception, e:
            print(e)
        print "wait for queue..."
        sleep(10)

def wait_for_building(name, number):
    while True:
        try:
            info = j.get_build_info(name,number)
            return
        except:
            pass
        print "wait for building..."
        sleep(10)

def wait_for_finished(name, number):
    while True :
        try:
            info = j.get_build_info(name, number)
            if info['building'] is False: return info['result']
        except Exception, e:
            print(e)
        print "wait for finished..."
        sleep(10)

j = jenkins.Jenkins(url, username, password)

#wait_for_queue(name)

#next_build_number = j.get_job_info(name)['nextBuildNumber']
#print('next build number=' + str(next_build_number))

j.build_job(name)

#wait_for_building(name, next_build_number)

#result = wait_for_finished(name, next_build_number)
#print('result =' + result)

#output = j.get_build_console_output(name, next_build_number)
#print(output)
