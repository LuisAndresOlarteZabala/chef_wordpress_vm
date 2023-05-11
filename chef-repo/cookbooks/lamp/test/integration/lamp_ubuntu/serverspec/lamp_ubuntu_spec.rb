# PRIMERA PRUEBA

# ejecutar => kitchen test package-ubuntu-1804

# require 'spec_helper'

# describe package('vim') do 
#     it {should be_installed} 
# end

# describe command('vim --version') do
#     its (:stdout) {should match /VIM - Vi IMproved/} 
# end

# SEGUNDA PRUEBA TRAS EJECUTAR kitchen converge package-ubuntu-1804

# ejecutar => kitchen verify package-ubuntu-1804

# Ej de casos de prueba separados para Ubuntu y CentOS. 

require'spec_helper'

if os[:family] == 'ubuntu' 

    # Validación de Paquetes instalados y servicios
    describe package('apache2') do
        it { should be_installed }
    end

    describe service('apache2') do
        it { should be_enabled }
        it { should be_running }
    end

    describe package('mysql-server') do
        it { should be_installed }
    end

    describe package('mysql-client') do
        it { should be_installed }
    end

    describe service('mysql') do
        it { should be_enabled }
        it { should be_running }
    end

    describe package('php') do
        it { should be_installed }
    end

    describe package('php-mysql') do
        it { should be_installed }
    end

    # Validación de configuraciones:
    describe file('/etc/apache2/sites-enabled/000-default.conf') do
        it { should_not exist }
    end

    describe file('/etc/apache2/sites-available/vagrant.conf') do
        it { should exist }
    end

    describe file('/etc/apache2/sites-enabled/vagrant.conf') do
        it { should be_symlink }
        its('link_target') { should eq '/etc/apache2/sites-available/vagrant.conf' }
    end

    
    describe command("mysql -u root -p123456 -e 'SHOW DATABASES LIKE \"wordpress_db\"'") do
        its('stdout') { should match /wordpress_db/ }
    end
    describe command("mysql -u root -p123456 -e 'SELECT User FROM mysql.user WHERE User = \"wp_user\"'") do
        its('stdout') { should match /wp_user/ }
    end
end

if os[:family] =='redhat'
    describe package('vim-minimal') do 
        it {should be_installed}
    end

    describe package('vim-enhanced') do
        it {should be_installed} 
    end
end

describe command('vim --version') do
    its (:stdout) {should match /VIM - Vi IMproved/} 
end
  