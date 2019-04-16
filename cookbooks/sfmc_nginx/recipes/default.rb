#
# Cookbook:: sfmc_nginx
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# recipe fails to install nginx in kitchen due to dependency issue:
['openssl', 'openssl-libs'].each do |pkg|
  package pkg do
    package_name pkg
    action :upgrade
  end
end

include_recipe 'nginx::default'

# This should be easier to do!
# Unfortunately, the cookbook we're wrapping only enables streams if the package
# was installed from source with the `--with-stream` flag configured.
# https://github.com/sous-chefs/nginx/blob/master/templates/default/nginx.conf.erb
conf_plain_file '/etc/nginx/nginx.conf' do
  pattern %r{stream \{\n  include \/etc\/nginx\/streams-enabled\/\*;\n\}}
  new_line "stream {\n  include /etc/nginx/streams-enabled/*;\n}\n"
  action :append
  notifies :reload, 'service[nginx]', :delayed
end

node['proxies'].each do |protocol, ports|
  ports.each do |port, servers|
    nginx_stream "#{protocol}_#{port}" do
      template 'stream.erb.conf'
      name "#{protocol}_#{port}"
      variables(
        protocol: protocol,
        port: port,
        servers: servers
      )
    end
  end
end
