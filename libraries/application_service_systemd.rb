require_relative 'application_service_resource'

class Chef
  class Provider
    class ApplicationServiceSystemd < ApplicationService

      if defined?(provides) # foodcritic ~FC023
        provides :application_service, os: 'linux' do |node|
          Chef::Resource::ApplicationService.systemd?
        end

        action :create do
          s = systemd_service new_resource.name do
            after new_resource.start_condition
            install do
              wanted_by 'multi-user.target'
            end
            service do
              user new_resource.user
              environment new_resource.environment
              exec_start new_resource.start
              restart new_resource.respawn
              exec_stop new_resource.stop
              exec_start_pre new_resource.pre_start
              exec_start_post new_resource.post_start
              exec_stop_post new_resource.post_stop
            end
          end
          s.description new_resource.description
        end
      end
    end
  end
end
