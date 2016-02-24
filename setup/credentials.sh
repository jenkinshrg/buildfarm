#!/bin/bash

if [ -f /home/anonymous/.gitconfig ]; then
  cp -a /home/anonymous/.gitconfig /home/vagrant
fi
if [ -f /home/anonymous/.git-credentials ]; then
  cp -a /home/anonymous/.git-credentials /home/vagrant
fi
if [ -d /home/anonymous/.ssh ]; then
  cp -a /home/anonymous/.ssh /home/vagrant
fi
if [ -d /home/anonymous/.jenkinshrg ]; then
  cp -a /home/anonymous/.jenkinshrg /home/vagrant
fi

if [ -e /var/lib/jenkins ]; then
  sudo cp /home/vagrant/.gitconfig /var/lib/jenkins
  sudo chown jenkins:jenkins /var/lib/jenkins/.gitconfig
  sudo cp /home/vagrant/.git-credentials /var/lib/jenkins
  sudo chown jenkins:jenkins /var/lib/jenkins/.git-credentials
  sudo cp -r /home/vagrant/.ssh /var/lib/jenkins
  sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
fi
