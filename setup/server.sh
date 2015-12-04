#!/bin/bash

sudo apt-add-repository -y ppa:nginx/stable
sudo apt-get update
sudo apt-get -y install nginx

sudo rm /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
cat << \EOT | sudo tee /etc/nginx/sites-available/jenkins
upstream app_server { 
    server localhost:8080 fail_timeout=0; 
} 

server { 
    listen 80; 
    listen [::]:80 default ipv6only=on; 
    server_name jenkinshrg.a01.aist.go.jp; 

    location / { 
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; 
        proxy_set_header Host $http_host; 
        proxy_redirect off; 

        if (!-f $request_filename) { 
            proxy_pass http://app_server; 
            break; 
        } 
    } 
}
EOT
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
sudo service nginx restart
