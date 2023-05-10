#
# Cookbook:: lamp
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
#include_recipe '::apache'
#include_recipe '::mysql'
#include_recipe '::php'
#include_recipe '::facts'

  begin
    include_recipe "::lamp_#{node['lamp']['family']}" rescue 
    Chef::Exceptions::RecipeNotFound
    Chef::Log.warn"A #{node['lamp']['family']} recipe does not exist for the PLATFORM FAMILY: #{node['platform_family']}"
  end