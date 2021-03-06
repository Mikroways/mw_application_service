application_service 'all_params' do
  description 'all params description'
  user 'some_user'
  path '/tmp'
  start 'a command'
  stop 'a stop useless command for uspart but important for systemd'
  environment :home => '/home/some_user', :path => '/usr/bin'
  start_condition 'network.target'
  stop_condition 'stopped networking'
  respawn 'on-success'
  pre_start 'pre start command'
  post_start 'post start command'
  pre_stop 'pre stop command'
  post_stop 'post stop command'
end
