#!/bin/bash
 
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
wget https://wordpress.org/latest.tar.gz
tar zxf latest.tar.gz
sudo dnf install wget php-mysqlnd httpd php-fpm php-mysqli mariadb105-server php-json php php-devel -y
sudo mv wordpress/* /var/www/html
sudo systemctl restart httpd
sudo rm -rf /var/www/html/index.html

sudo systemctl start mariadb
sudo systemctl enable mariadb
