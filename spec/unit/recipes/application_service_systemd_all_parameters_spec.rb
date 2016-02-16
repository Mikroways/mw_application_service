#
# Cookbook Name:: mw_application
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'application_service_test::all_parameters_systemd' do

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
      expect(chef_run).to create_application_service('all_params')
    end
  end

  context 'stepping into application_service[all_params] resource' do
    it 'create systemd_service simple_app' do
      expect(chef_run).to create_systemd_service('all_params').with(
        description: 'all params description',
        user: 'some_user',
        exec_start: 'a command',
        after: 'network.target',
        wanted_by: 'multi-user.target',
        restart: 'on-success',
        environment: { home: '/home/some_user', path: '/usr/bin' },
        exec_stop: 'a stop useless command for uspart but important for systemd',
        exec_start_pre: 'pre start command',
        exec_start_post: 'post start command',
        exec_stop_post: 'post stop command'
      )
    end

  end
end

