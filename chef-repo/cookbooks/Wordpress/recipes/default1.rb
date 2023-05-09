

# Crear usuario y otorgar permisos para la base de datos de WordPress
execute 'create_wordpress_user' do
    command "mysql -u root -e \"CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'L123456'; GRANT ALL ON wordpress_db.* TO 'wp_user'@'localhost' IDENTIFIED BY 'L123456'; FLUSH PRIVILEGES;\""
    
end

cd /home/ubuntu
sudo wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
sudo systemctl reload apache2
ls -l
sudo chmod +x ~/wp-cli.phar
sudo mv ~/wp-cli.phar /usr/local/bin/wp

#sudo mkdir -p /var/www/html/blog
directory '/var/www/html/blog' do
    action :create
  end

# Instalar wordpress con WP Cli
execute 'WPCLI_download_core' do
    command "wp core download --path=/var/www/html/blog --allow-root;wp core config --path=/var/www/html/blog --dbname=wordpress_db --dbuser=wp_user --dbpass=L123456 --dbhost=localhost --dbcharset=utf8mb4 --extra-php='define("WP_DEBUG", true);' --allow-root"
end

execute 'WPCLI_install core' do
    command "wp core install --path=/var/www/html/blog --url=44.216.4.5/blog/ --title="Actividad Grupal" --admin_user=admin --admin_password=L70287887$$$ --admin_email=josephjacinto@hotmail.es --allow-root"
end  
execute 'WPCLI_install_theme' do
    command "wp theme install colibri-wp --activate --path=/var/www/html/blog --allow-root"
end
execute 'WPCLI_install_theme' do
    command "wp post create --post_title="Herramientas de Automatizacion de despliegues - Actividad Grupal 1: Instalación completa de wordpress con Chef" --post_content="Integrantes:<br/>Fernando Augusto Contreras Pardo<br/>Joseph Junior Jacinto Paredes<br/>Luis Andres Olarte<br/>" --post_type=page --post_status=publish --path=/var/www/html/blog --allow-root"
end
