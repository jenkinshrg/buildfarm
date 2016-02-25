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
