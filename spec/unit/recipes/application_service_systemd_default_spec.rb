#
# Cookbook Name:: mw_application
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'application_service_test::default' do

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(
      platform: 'centos',
      version: '7.0',
      step_into: 'application_service')
    runner.converge(described_recipe)
  end

  before do
    set_systemd!
  end

  context 'compiling the test recipe' do
    it 'converges successfully' do
      expect(chef_run).to create_application_service('simple_app')
    end
  end

  context 'stepping into application_service[simple_app] resource' do
    it 'create systemd_service simple_app' do
      expect(chef_run).to create_systemd_service('simple_app').with(
        description: 'some description',
        user: 'simple_app',
        exec_start: 'yes',
        after: 'network.target remote-fs.target',
        wanted_by: 'multi-user.target',
        restart: 'on-failure'
      )
    end

  end
end

