require'spec_helper'

if os[:family] =='centos'
    # Validación de Paquetes instalados y servicios
    describe package('httpd') do
        it { should be_installed }
    end

    describe service('httpd') do
        it { should be_enabled }
        it { should be_running }
    end

    describe service('mysql') do
        it { should be_enabled }
        it { should be_running }
    end

    describe package('php') do
        it { should be_installed }
    end

    describe package('php-mysqlnd') do
        it { should be_installed }
    end

    # Validación de configuraciones:
    describe file('/etc/httpd/conf.d/welcome.conf') do
        it { should_not exist }
    end

    describe file('/etc/httpd/conf.d/vagrant.conf') do
        it { should exist }
    end

    describe command("mysql -u root -p123456 -e 'SHOW DATABASES LIKE \"wordpress_db\"'") do
        its('stdout') { should match /wordpress_db/ }
    end
    describe command("mysql -u root -p123456 -e 'SELECT User FROM mysql.user WHERE User = \"wp_user\"'") do
        its('stdout') { should match /wp_user/ }
    end
end