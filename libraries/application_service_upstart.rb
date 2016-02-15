class Chef
  class Provider
    class ApplicationServiceUpstart < ApplicationService
      if defined?(provides) # foodcritic ~FC023
        provides :application_service, os: 'linux' do |node|
           Chef::Sugar::Init.upstart?(node)
        end

        action :create do
          template "#{new_resource.name} :create /etc/init/#{new_resource.name}.conf" do
            path "/etc/init/#{new_resource.name}.conf"
            source 'upstart/application.erb'
            owner 'root'
            group 'root'
            mode '0644'
            variables(
              user: new_resource.user,
              description: new_resource.description,
              path: new_resource.path,
              command: new_resource.start,
              environment: new_resource.environment,
              start_on: new_resource.start_condition,
              stop_on: new_resource.stop_condition,
              respawn: new_resource.respawn,
              pre_start: new_resource.pre_start,
              post_start: new_resource.post_start,
              pre_stop: new_resource.pre_stop,
              post_stop: new_resource.post_stop
            )
            cookbook 'mw_application_service'
            action :create
          end

        end
      end
    end
  end
end
