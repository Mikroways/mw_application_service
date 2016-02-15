#
# Cookbook Name:: mw_application
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'application_service_test::all_parameters' do

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
      expect(chef_run).to create_application_service('all_params')
    end
  end

  context 'stepping into application_service[all_params] resource' do
    let(:tpl_content) do
      <<CONTENT
description "all params description"
start on started networking
stop on stopped networking
env HOME='/home/some_user'
env PATH='/usr/bin'
setuid some_user
chdir /tmp
pre-start exec pre start command
post-start exec post start command
exec a command
pre-stop exec pre stop command
post-stop exec post stop command
CONTENT
    end

    it 'creates template /etc/init/all_params.conf' do
      expect(chef_run).to create_template('all_params :create /etc/init/all_params.conf')
    end

    it 'creates template with expected content' do
      expect(chef_run).to render_file('all_params :create /etc/init/all_params.conf')
      .with_content { |content| expect(content.squeeze "\n").to eq tpl_content }
    end

  end
end

