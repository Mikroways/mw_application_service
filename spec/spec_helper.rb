require 'chefspec'
require 'chefspec/berkshelf'
require_relative '../libraries/application_service_resource'

# The only way to mock usptart? systemd? chef-sugar helpers is like this
def set_systemd!
  allow(Chef::Platform::ServiceHelpers).to receive(:service_resource_providers).and_return([:redhat, :systemd])
end

# The only way to mock usptart? systemd? chef-sugar helpers is like this
def set_upstart!
  allow(Chef::Platform::ServiceHelpers).to receive(:service_resource_providers).and_return([:upstart])
end


at_exit { ChefSpec::Coverage.report! }
