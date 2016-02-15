#
# Cookbook Name:: mw_application
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'application_service_test::default' do

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      version: '14.04',
      step_into: 'application_service')
    runner.converge(described_recipe)
  end

  before do
    set_upstart!
  end


  context 'compiling the test recipe' do
    it 'converges successfully' do
      expect(chef_run).to create_application_service('simple_app')
    end
  end

  context 'stepping into application_service[simple_app] resource' do
    let(:tpl_content) do
      <<CONTENT
description "some description"
start on runlevel [2345]
stop on runlevel [!2345]
respawn
setuid simple_app
chdir /tmp
exec yes
CONTENT
    end

    it 'creates template /etc/init/simple_app.conf' do
      expect(chef_run).to create_template('simple_app :create /etc/init/simple_app.conf')
    end

    it 'creates template with expected content' do
      expect(chef_run).to render_file('simple_app :create /etc/init/simple_app.conf')
      .with_content { |content| expect(content.squeeze "\n").to eq tpl_content }
    end

  end
end

