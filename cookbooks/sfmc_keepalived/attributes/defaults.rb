default['keepalived']['hosts'] = { 'lb1' => 'nginx',
                                   'lb2' => 'nginx' }
services = { 'nginx' => { 'virtual_router_id' => 1,
                          'priority' => 50,
                          'virtual_ipaddress' => ['10.0.0.100'],
                          'peers' => { 'lb1' => '10.0.0.4',
                                       'lb2' => '10.0.0.5' } } }
default['keepalived']['services'] = services
