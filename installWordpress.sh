#!/bin/bash

cd /home/ubuntu
sudo wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo systemctl reload apache2
ls -l
sudo chmod +x ~/wp-cli.phar
sudo mv ~/wp-cli.phar /usr/local/bin/wp
sudo mkdir -p /var/www/html/blog
sudo wp core download --path=/var/www/html/blog --allow-root
sudo wp core config --path=/var/www/html/blog --dbname=wordpress_db --dbuser=wp_user --dbpass=L123456 --dbhost=localhost --dbcharset=utf8mb4 --extra-php='define("WP_DEBUG", true);' --allow-root
sudo wp core install --path=/var/www/html/blog --url=44.216.4.5/blog/ --title="Actividad Grupal" --admin_user=admin --admin_password=L70287887$$$ --admin_email=josephjacinto@hotmail.es --allow-root
sudo wp theme install colibri-wp --activate --path=/var/www/html/blog --allow-root
sudo wp post create --post_title="Cloud Computing, DevOps and DevOps Culture - Actividad Grupal: Despliegue de una aplicación mediante virtualización y AWS" --post_content="Integrantes:<br/>Fernando Augusto Contreras Pardo<br/>Wilson Edward Yoel Narro Esquivel<br/>Joseph Junior Jacinto Paredes<br/>Jorge Sabogal Sepulveda<br/>" --post_type=page --post_status=publish --path=/var/www/html/blog --allow-root