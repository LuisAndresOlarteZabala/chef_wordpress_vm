#
# Cookbook:: lamp
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

  begin
    case node['platform']
      when 'ubuntu'
        include_recipe "lamp::lamp_ubuntu"
      when 'centos'
        include_recipe "lamp::lamp_centos"
      else
        Chef::Log.warn("Platform not supported: #{node['platform']}")
    end
  end
  