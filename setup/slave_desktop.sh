#!/bin/bash

if [ $# -lt 1 ] ;  then
  echo "Usage:" $0 "nodename [url]"
  exit
fi

NAME=$1
URL=${2:-http://jenkinshrg.a01.aist.go.jp}

wget -q -O $HOME/slave.jar $URL/jnlpJars/slave.jar

mkdir -p $HOME/.config/autostart
cat << EOL | tee $HOME/.config/autostart/jenkins-slave.desktop
[Desktop Entry]
Type=Application
Exec=java -jar $HOME/slave.jar -jnlpUrl $URL/computer/$NAME/slave-agent.jnlp
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Jenkins Slave
Comment=Start Jenkins Slave For Desktop Application
EOL

java -jar $HOME/slave.jar -jnlpUrl $URL/computer/$NAME/slave-agent.jnlp &

sudo sh -c 'echo "'$USER' ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers'
