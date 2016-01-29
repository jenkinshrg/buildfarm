#!/bin/bash

sudo apt-add-repository -y ppa:nginx/stable
sudo apt-get update
sudo apt-get -y install nginx

cat << \EOL | sudo tee /etc/nginx/sites-available/default
server {
        listen 80;
        server_name localhost;
        location / {
                proxy_set_header Host $http_host;
                proxy_pass http://localhost:8080;
        }
}
EOL
sudo service nginx restart
