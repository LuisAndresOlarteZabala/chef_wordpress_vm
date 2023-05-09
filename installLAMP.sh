#!/bin/bash

sleep 30

sudo apt-update
sudo apt install apache2 -y
sudo apt install mysql-server mysql-client -y
sudo mysql -u root -p123456 -e 'CREATE DATABASE wordpress_db'
sudo mysql -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'L123456';"
sudo mysql -e "GRANT ALL ON wordpress_db.* TO 'wp_user'@'localhost' IDENTIFIED BY 'L123456';"
sudo mysql -e "FLUSH PRIVILEGES"
sudo apt install php php-mysql -y


