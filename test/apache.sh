#!/bin/bash

sudo dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y

# Start and enable services
sudo systemctl start httpd
sudo systemctl enable httpd


# Download WordPress
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mv wordpress/* /var/www/html/
sudo rm /var/www/html/index.html
sudo chown -R apache:apache /var/www/html/
sudo chmod -R 755 /var/www/html/