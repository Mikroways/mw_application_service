require 'chef/resource/lwrp_base'
require 'chef/sugar'

class Chef
  class Resource
    class ApplicationService < Chef::Resource::LWRPBase

      include Chef::Sugar::Init

      self.resource_name = :application_service
      provides :application_service

      actions :create
      default_action :create

      attribute :name,  kind_of: String, name_property: true, required: true
      attribute :description,  kind_of: String, required: true
      attribute :user, kind_of: String, required: true, default: lazy {|resource| resource.name}
      attribute :path, kind_of: String, required: true
      attribute :start, kind_of: String, required: true
      attribute :stop, kind_of: String
      attribute :environment, kind_of: Hash, default: {}

      # start_on upstart
      # after systemd
      attribute :start_condition, kind_of: String,
        default: lazy { |resource|
        if resource.upstart?(resource.node)
          'runlevel [2345]'
        elsif resource.systemd?(resource.node)
          'network.target remote-fs.target'
        end
      }

      # stop_on upstart
      # after systemd
      attribute :stop_condition, kind_of: String,
        default: lazy { |resource|
        if resource.upstart?(resource.node)
          "runlevel [!2345]"
        end
      }

      # respawn upstart
      # restart systemd
      attribute :respawn, kind_of: [TrueClass, FalseClass, String],
        default: lazy { |resource|
        if resource.upstart?(resource.node)
          true
        elsif resource.systemd?(resource.node)
          'on-failure'
        end
      }
      attribute :pre_start, kind_of: String
      attribute :post_start, kind_of: String
      attribute :pre_stop, kind_of: String
      attribute :post_stop, kind_of: String
    end
  end
end
