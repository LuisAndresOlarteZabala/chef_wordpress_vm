#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2009-2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#if node.has_key?("ec2")
#  server_fqdn = node['ec2']['public_hostname']
#else
#  server_fqdn = node['fqdn']
#end
#
#node.normal['wordpress']['db']['password'] = secure_password
#node.normal['wordpress']['keys']['auth'] = secure_password
#node.normal['wordpress']['keys']['secure_auth'] = secure_password
#node.normal['wordpress']['keys']['logged_in'] = secure_password
#node.normal['wordpress']['keys']['nonce'] = secure_password

remote_file "#{Chef::Config[:file_cache_path]}/wordpress-#{node['wordpress']['version']}.tar.gz" do
  #checksum node['wordpress']['checksum']
  source "http://wordpress.org/wordpress-#{node['wordpress']['version']}.tar.gz"
  mode "0644"
end

directory "#{node['wordpress']['dir']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

execute "untar-wordpress" do
  cwd node['wordpress']['dir']
  command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/wordpress-#{node['wordpress']['version']}.tar.gz"
  creates "#{node['wordpress']['dir']}/wp-settings.php"
end



#sudo mkdir -p /var/www/html/blog
directory '/var/www/html/blog' do
    action :create
    mode "0755"
  end


  remote_file '/usr/local/bin/wp-cli.phar' do
    source 'https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
    mode '0755'
    action :create
    force_unlink true
  end


  link '/usr/local/bin/wp' do
    to '/usr/local/bin/wp-cli.phar'
    link_type :symbolic
  end
# Instalar wordpress con WP Cli
execute 'WPCLI_download_core' do
  command "sudo wp core download --path=/var/www/html/blog --allow-root" 
end

execute 'WPCLI_download_core' do
  command "sudo wp core config --path=/var/www/html/blog --dbname=wordpress_db --dbuser=wp_user --dbpass=L123456 --dbhost=localhost --dbcharset=utf8mb4 --extra-php='define(\"WP_DEBUG\", true);' --allow-root" 
end

execute 'WPCLI_install core' do
  command "sudo wp core install --path=/var/www/html/blog --url=192.168.33.40/blog/ --title=\"Actividad Grupal\" --admin_user=admin --admin_password=L70287887$$$ --admin_email=josephjacinto@hotmail.es --allow-root"
end  
execute 'WPCLI_install_theme' do
  command "sudo wp theme install colibri-wp --activate --path=/var/www/html/blog --allow-root"
end
execute 'Configure Post' do
  command "sudo wp post create --post_title=\"Herramientas de Automatizacion de despliegues - Actividad Grupal 1: Instalación completa de wordpress con Chef\" --post_content=\"Integrantes:<br/>Fernando Augusto Contreras Pardo<br/>Joseph Junior Jacinto Paredes<br/>Luis Andres Olarte<br/>\" --post_type=page --post_status=publish --path=/var/www/html/blog --allow-root"
end




#execute "mysql-install-wp-privileges" do
#  command "/usr/bin/mysql -u root -p\"#{node['mysql']['server_root_password']}\" < #{node['mysql']['conf_dir']}/wp-grants.sql"
#  action :nothing
#end
#
#template "#{node['mysql']['conf_dir']}/wp-grants.sql" do
#  source "grants.sql.erb"
#  owner "root"
#  group "root"
#  mode "0600"
#  variables(
#    :user     => node['wordpress']['db']['user'],
#    :password => node['wordpress']['db']['password'],
#    :database => node['wordpress']['db']['database']
#  )
#  notifies :run, "execute[mysql-install-wp-privileges]", :immediately
#end
#
#execute "create #{node['wordpress']['db']['database']} database" do
#  command "/usr/bin/mysqladmin -u root -p\"#{node['mysql']['server_root_password']}\" create #{node['wordpress']['db']['database']}"
#  not_if do
#    require 'mysql'
#    m = Mysql.new("localhost", "root", node['mysql']['server_root_password'])
#    m.list_dbs.include?(node['wordpress']['db']['database'])
#  end
#  notifies :create, "ruby_block[save node data]", :immediately unless Chef::Config[:solo]
#end
#
## save node data after writing the MYSQL root password, so that a failed chef-client run that gets this far doesn't cause an unknown password to get applied to the box without being saved in the node data.
#unless Chef::Config[:solo]
#  ruby_block "save node data" do
#    block do
#      node.save
#    end
#    action :create
#  end
#end
#
#log "Navigate to 'http://#{server_fqdn}/wp-admin/install.php' to complete wordpress installation" do
#  action :nothing
#end
#
#template "#{node['wordpress']['dir']}/wp-config.php" do
#  source "wp-config.php.erb"
#  owner "root"
#  group "root"
#  mode "0644"
#  variables(
#    :database        => node['wordpress']['db']['database'],
#    :user            => node['wordpress']['db']['user'],
#    :password        => node['wordpress']['db']['password'],
#    :auth_key        => node['wordpress']['keys']['auth'],
#    :secure_auth_key => node['wordpress']['keys']['secure_auth'],
#    :logged_in_key   => node['wordpress']['keys']['logged_in'],
#    :nonce_key       => node['wordpress']['keys']['nonce']
#  )
#  notifies :write, "log[Navigate to 'http://#{server_fqdn}/wp-admin/install.php' to complete wordpress installation]"
#end
#
#apache_site "000-default" do
#  enable false
#end
#
#web_app "wordpress" do
#  template "wordpress.conf.erb"
#  docroot "#{node['wordpress']['dir']}"
#  server_name server_fqdn
#  server_aliases node['wordpress']['server_aliases']
#end
