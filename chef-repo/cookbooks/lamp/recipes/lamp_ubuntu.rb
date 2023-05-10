apt_update 'Update the apt cache daily' do
  frequency 86400
  action :periodic
end

#-------------------Intalar Apache---------------------
package 'apache2'

service 'apache2' do
  supports :status => true
  action :nothing
end

file '/etc/apache2/sites-enabled/000-default.conf' do
  action :delete
end

template '/etc/apache2/sites-available/vagrant.conf' do
  source 'virtual-hosts.conf.erb'
  notifies :restart, resources(:service => "apache2")
end

link '/etc/apache2/sites-enabled/vagrant.conf' do
  to '/etc/apache2/sites-available/vagrant.conf'
  notifies :restart, resources(:service => "apache2")
end


#--------------------My SQL----------------------------

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
#------------------------------------PHP-------------------------------
package 'php' do
  action :install
end
package 'php-mysql' do
  action :install
  notifies :restart, resources(:service => "apache2")
end
