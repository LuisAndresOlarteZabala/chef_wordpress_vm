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
      expect(chef_run).to include_recipe('::lamp_ubuntu') 
    end
  end
  
  #context "with 'source' as install_method" do
  #  
  #  override_attributes['vim']['install_method'] = 'source' 
  #
  #  it "should include the vim_pruebas_chef::source recipe when install_method='source'" do 
  #    expect(chef_run).to include_recipe('vim_pruebas_chef::source') 
  #  end
  #end
end


