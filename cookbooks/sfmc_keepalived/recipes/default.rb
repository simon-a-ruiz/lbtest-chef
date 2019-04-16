#
# Cookbook:: sfmc_keepalived
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

execute 'sysctl' do
  command 'sysctl -p'
  action :nothing
end

execute 'add_nonlocal_bind' do
  command 'echo "net.ipv4.ip_nonlocal_bind=1" >> /etc/sysctl.conf'
  action :run
  not_if 'grep "net.ipv4.ip_nonlocal_bind=1" /etc/sysctl.conf'
  notifies :run, 'execute[sysctl]', :immediately
end

include_recipe 'keepalived::default'

service = node['keepalived']['hosts'][node['hostname']]
keepalived_vrrp_script "chk_#{service}" do
  interval 2
  weight 2
  script "\"/usr/sbin/pidof #{service}\""
  user 'root'
end

serv_settings = node['keepalived']['services'][service]

file '/root/cookbook_out' do
  content "serv:#{service}\nsets:#{serv_settings}\n"
  mode '0777'
  owner 'root'
  group 'root'
end

peers = node['keepalived']['services'][service]['peers']
unicast_src_ip = peers[node['hostname']]
unicast_peer = peers.reject { |_, v| v == peers[node['hostname']] }.values

keepalived_vrrp_instance 'VI_01' do
  interface node['network']['default_interface']
  virtual_router_id serv_settings['virtual_router_id']
  priority serv_settings['priority']
  master true
  unicast_src_ip unicast_src_ip
  unicast_peer unicast_peer
  authentication(
    auth_type: 'PASS',
    auth_pass: 'supesecr'
  )
  track_script %W[chk_#{service}]
  virtual_ipaddress serv_settings['virtual_ipaddress']
end
