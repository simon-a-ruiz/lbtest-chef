name 'sfmc_nginx'
maintainer 'MC Social Infrastructure'
maintainer_email 'mcsocialinfra@salesforce.com'
license 'All Rights Reserved'
description 'Installs/Configures sfmc_nginx'
long_description 'Installs/Configures sfmc_nginx'
version '0.1.1'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'nginx'
depends 'conf'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.internal.sfmc.co/chef-cookbooks/sfmc_nginx/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.internal.sfmc.co/chef-cookbooks/sfmc_nginx/issues'
