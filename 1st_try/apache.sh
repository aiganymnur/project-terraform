#!/bin/bash

sudo amazon-linux-extras install mariadb10.5 -y
sudo amazon-linux-extras install php8.2 -y
sudo yum install -y httpd
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo mv wordpress/* /var/www/html
sudo rm -rf wordpress/
sudo systemctl start mariadb httpd
sudo systemctl enable mariadb httpd
sudo systemctl restart httpd