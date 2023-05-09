apt_update 'Update the apt cache daily' do
    frequency 86400
    action :periodic
  end
  
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
  
  # cooobook_file => transfer files. 
  # "#{node['apache']['document_root']}/index.html"  is path to the file to be created
  # source 'index.html' significa que dentro de la carpeta "files" busque "index.html"
  

 include_recipe '::facts'
