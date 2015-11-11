#!/bin/bash

sudo sh -c "echo '30 * * * * vagrant cd /home/vagrant && rm -fr jenkinshrg.github.io && git clone https://github.com/jenkinshrg/jenkinshrg.github.io.git && cd jenkinshrg.github.io && bash -xe .jenkins.sh' >> /etc/crontab"

sudo service cron restart
