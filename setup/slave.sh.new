#!/bin/bash

sudo useradd -s /bin/bash -m jenkins-slave
sudo su -l jenkins-slave -c "wget -q http://localhost:8080/jnlpJars/slave.jar"
sudo sh -c 'echo "jenkins-slave ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

sudo cp etc/default/jenkins-slave /etc/default
sudo cp etc/init.d/jenkins-slave /etc/init.d

sudo mkdir -p /var/log/jenkins-slave
sudo chown -R jenkins-slave.jenkins-slave /var/log/jenkins-slave

#sudo apt-get -y install sysv-rc-conf
#sudo chkconfig jenkins-slave on
sudo update-rc.d jenkins-slave defaults
#sudo insserv jenkins-slave

sudo service jenkins-slave start
