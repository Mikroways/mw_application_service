require 'chefspec'
require 'chefspec/berkshelf'

# The only way to mock usptart? systemd? chef-sugar helpers is like this
def set_systemd!
  allow(::IO).to receive(:read).and_call_original
  allow(::IO).to receive(:read).with('/proc/1/comm').and_return('systemd')
  allow(::File).to receive(:executable?).and_call_original
  allow(::File).to receive(:executable?).with('/sbin/initctl').and_return(false)
end

# The only way to mock usptart? systemd? chef-sugar helpers is like this
def set_upstart!
  allow(::IO).to receive(:read).and_call_original
  allow(::IO).to receive(:read).with('/proc/1/comm').and_return('')
  allow(::File).to receive(:executable?).and_call_original
  allow(::File).to receive(:executable?).with('/sbin/initctl').and_return(true)
end


at_exit { ChefSpec::Coverage.report! }
