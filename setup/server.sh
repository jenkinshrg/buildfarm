#!/bin/bash

wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install jenkins

sleep 30
wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin git
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin multiple-scms
#java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin clone-workspace-scm
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin embeddable-build-status
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin timestamper 
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin ansicolor 
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin parameterized-trigger
#java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cmakebuilder
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin warnings
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cobertura
#java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cccc
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cppcheck
#java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin htmlpublisher
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin valgrind
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin xunit
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin email-ext
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin join
rm jenkins-cli.jar
sudo service jenkins restart
sleep 30

cat << EOL | sudo tee -a /var/cache/jenkins/war/css/style.css
pre {
    background-color: #2a2a2a;
    color: #f1f1f1;
}
EOL

sudo sh -c "echo '59 * * * * vagrant cd /home/vagrant && rm -fr jenkinshrg.github.io && git clone https://github.com/jenkinshrg/jenkinshrg.github.io.git && cd jenkinshrg.github.io && bash -xe .jenkins.sh' >> /etc/crontab"
sudo service cron restart

cat << EOL | python
import sys
import os
from selenium import webdriver

driver = webdriver.PhantomJS(service_log_path=os.devnull)
driver.get("http://localhost:8080/configureSecurity/")
driver.implicitly_wait(10)
element = driver.find_element_by_id('cb14')
element.click()
element = driver.find_element_by_css_selector("input[type='radio'][value='fixed']")
element.click()
element = driver.find_element_by_id('slaveAgentPortId')
element.clear()
element.send_keys("9000")
element = driver.find_element_by_id('yui-gen6-button')
element.click()
driver.quit()
EOL
