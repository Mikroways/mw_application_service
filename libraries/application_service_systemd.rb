require 'chef/sugar'
class Chef
  class Provider
    class ApplicationServiceUpstart < ApplicationService

      if defined?(provides) # foodcritic ~FC023
        provides :application_service, os: 'linux' do |node|
            Chef::Sugar::Init.systemd?(node)
        end

        action :create do

          s = systemd_service new_resource.name
          s.description new_resource.description
          s.after new_resource.start_condition
          s.install do
            wanted_by 'multi-user.target'
          end
          s.service do
            environment new_resource.environmnent
            exec_start new_resource.start
            exec_stop new_resource.stop
            exec_start_pre new_resource.pre_start
            exec_start_post new_resource.post_start
            exec_stop_pre new_resource.pre_stop
            exec_stop_post new_resource.post_stop
          end
        end
      end
    end
  end
end
