#!/bin/bash

wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get -y install jenkins
sleep 30

cat << EOL | sudo tee /var/lib/jenkins/config.xml
<?xml version='1.0' encoding='UTF-8'?>
<hudson>
  <numExecutors>0</numExecutors>
  <slaveAgentPort>9000</slaveAgentPort>
</hudson>
EOL

cat << EOL | sudo tee /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml
<?xml version='1.0' encoding='UTF-8'?>
<jenkins.model.JenkinsLocationConfiguration>
  <adminAddress>jenkinshrg@gmail.com</adminAddress>
</jenkins.model.JenkinsLocationConfiguration>
EOL

cat << \EOL | sudo tee /var/lib/jenkins/hudson.plugins.emailext.ExtendedEmailPublisher.xml
<?xml version='1.0' encoding='UTF-8'?>
<hudson.plugins.emailext.ExtendedEmailPublisherDescriptor plugin="email-ext@2.40.5">
  <smtpAuthUsername>jenkinshrg@gmail.com</smtpAuthUsername>
  <smtpAuthPassword>xklNqRpMJK+CWD43Y2uiu5Ik8h8YJ5mBfYoMojMvYTw=</smtpAuthPassword>
  <smtpHost>smtp.gmail.com</smtpHost>
  <useSsl>true</useSsl>
  <charset>UTF-8</charset>
  <defaultContentType>text/plain</defaultContentType>
  <defaultSubject>[Jenkins] $PROJECT_NAME - # $BUILD_NUMBER - $BUILD_STATUS!</defaultSubject>
  <defaultBody>### Test notification ###&#xd;
&#xd;
Check console output at $BUILD_URL to view the results.&#xd;
Check report at http://jenkinshrg.github.io/ to view the results, when out of office.&#xd;
&#xd;
--- Name ---&#xd;
&#xd;
$PROJECT_NAME&#xd;
&#xd;
--- Number ---&#xd;
&#xd;
$BUILD_NUMBER&#xd;
&#xd;
--- Status ---&#xd;
&#xd;
$BUILD_STATUS&#xd;
&#xd;
--- Cause ---&#xd;
&#xd;
$CAUSE&#xd;
&#xd;
--- Failed Tests ---&#xd;
&#xd;
$FAILED_TESTS&#xd;
&#xd;
--- Changes ---&#xd;
&#xd;
${FILE,path=&quot;changes_email.txt&quot;}&#xd;
&#xd;
--- Artifacts ---&#xd;
&#xd;
${FILE,path=&quot;artifacts_email.txt&quot;}&#xd;
&#xd;
--- Artifacts (Google Drive) ---&#xd;
&#xd;
${FILE,path=&quot;uploads_email.txt&quot;}&#xd;
&#xd;
--- Build log ---&#xd;
&#xd;
$BUILD_LOG</defaultBody>
  <defaultPresendScript></defaultPresendScript>
  <defaultClasspath/>
  <defaultTriggerIds>
    <string>hudson.plugins.emailext.plugins.trigger.FailureTrigger</string>
    <string>hudson.plugins.emailext.plugins.trigger.UnstableTrigger</string>
  </defaultTriggerIds>
  <maxAttachmentSize>-1</maxAttachmentSize>
  <recipientList>jenkinshrg@gmail.com,hrg-notification-ml@aist.go.jp</recipientList>
  <defaultReplyTo></defaultReplyTo>
  <excludedCommitters></excludedCommitters>
  <overrideGlobalSettings>true</overrideGlobalSettings>
  <precedenceBulk>false</precedenceBulk>
  <debugMode>false</debugMode>
  <enableSecurity>false</enableSecurity>
  <requireAdminForTemplateTesting>false</requireAdminForTemplateTesting>
  <enableWatching>false</enableWatching>
</hudson.plugins.emailext.ExtendedEmailPublisherDescriptor>
EOL

wget -q http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin git
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin multiple-scms
# java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin clone-workspace-scm
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin embeddable-build-status
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin timestamper
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin ansicolor 
# java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin parameterized-trigger
# java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cmakebuilder
# java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin warnings
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cobertura
# java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cccc
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin cppcheck
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin valgrind
# java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin htmlpublisher
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin xunit
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin plot
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin email-ext
# java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin join
rm jenkins-cli.jar

sudo service jenkins restart
sleep 30

sudo sh -c 'echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'

sudo cp $HOME/.gitconfig /var/lib/jenkins
sudo chown jenkins:jenkins /var/lib/jenkins/.gitconfig
sudo cp $HOME/.git-credentials /var/lib/jenkins
sudo chown jenkins:jenkins /var/lib/jenkins/.git-credentials
sudo cp -r $HOME/.ssh /var/lib/jenkins
sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
sudo cp -r $HOME/.jenkinshrg /var/lib/jenkins
sudo chown -R jenkins:jenkins /var/lib/jenkins/.jenkinshrg
