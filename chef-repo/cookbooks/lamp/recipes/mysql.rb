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

# Instalar MySQL
package 'mysql-server' do
  action :install
  notifies :run, 'execute[create_wordpress_database]', :immediately
  notifies :run, 'execute[create_wordpress_user]', :immediately
end

package 'mysql-client' 

service 'mysql' do
  supports :status => true
  action :nothing
end



