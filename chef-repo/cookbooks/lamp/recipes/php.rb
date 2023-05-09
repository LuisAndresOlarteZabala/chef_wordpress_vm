package 'php' do
    action :install
end
package 'php-mysql' do
    action :install
    notifies :restart, resources(:service => "apache2")
end
