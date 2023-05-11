#
# Cookbook:: lamp
# Spec:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.


require 'spec_helper'

describe 'lamp::default' do
  platform 'ubuntu'

  context 'with default attributes' do

    it "should have default family 'ubuntu'" do
     expect(chef_run.node['lamp']['family']).to eq('ubuntu') 
    end

    it "should include the lamp::lamp_ubuntu recipe when family='ubuntu'" do 
      expect(chef_run).to include_recipe('lamp::lamp_ubuntu') 
    end
  end
end
describe 'lamp::default' do
  platform 'centos'

  context 'with modified attributes' do

    override_attributes['lamp']['family'] = 'centos' 

    it "should include the lamp::lamp_centos recipe when family=centos'" do 
      expect(chef_run).to include_recipe('lamp::lamp_centos') 
    end
  end
end