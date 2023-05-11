#-------------------Intalar httpd---------------------
execute 'actualizar dnf' do
  command "sudo dnf update -y"
  action :run
end

execute 'dnf instalar httpd' do
  command "sudo dnf install httpd -y"
  action :run
end

service 'httpd' do
  supports :status => true
  action [:enable, :start]
end

file '/etc/httpd/conf.d/welcome.conf' do
  action :delete
end

template '/etc/httpd/conf.d/vagrant.conf' do
  source 'virtual-hosts.conf.erb'
  notifies :restart, resources(:service => "httpd")
end

#--------------------MariaDB----------------------------

# Instala el repositorio de MariaDB
package 'mariadb-server' do
  action :install
end
package 'mariadb-client' do
  action :install
end

# Crear base de datos para WordPress
execute 'create_wordpress_database' do
  command "mysql -u root -p123456 -e 'CREATE DATABASE wordpress_db'"
  action :nothing
end

# Crear usuario y otorgar permisos para la base de datos de WordPress
execute 'create_wordpress_user' do
  command "mysql -u root -e \"CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'L123456'; GRANT ALL ON wordpress_db.* TO 'wp_user'@'localhost' IDENTIFIED BY 'L123456'; FLUSH PRIVILEGES;\""
  action :nothing
end

# Instala MariaDB Server
package 'MariaDB-server' do
  action :install
  notifies :run, 'execute[create_wordpress_database]', :immediately
  notifies :run, 'execute[create_wordpress_user]', :immediately
end

# Asegura que el servicio MariaDB esté habilitado al inicio y esté iniciado
service 'mysql' do
  action [:enable, :start]
end

#----------------------------- Instalar PHP--------------------------
package 'php' do
  action :install
end

# Instala la extensión MySQL de PHP
package 'php-mysqlnd' do
  action :install
  notifies :restart, 'service[httpd]'
end