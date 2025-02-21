#!/bin/bash

sudo yum install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y
sudo systemctl start httpd
sudo systemctl enable httpd
wget https://wordpress.org/latest.tar.gz
tar zxf latest.tar.gz


sudo mv wordpress/* /var/www/html
sudo chown -R  /var/www/html
sudo chmod 755 /var/www/html
sudo rm -rf /var/www/html/index.html

sudo systemctl restart httpd

