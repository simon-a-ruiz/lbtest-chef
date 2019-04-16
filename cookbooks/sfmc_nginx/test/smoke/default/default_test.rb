# Inspec test for recipe sfmc_nginx::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('nginx') do
  it { should be_installed }
end
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

portnums = %w[53 80 3389 8080]
portnums.each do |portnum|
  describe port(portnum) do
    it { should be_listening }
    its('processes') { should include 'nginx:' }
  end
end
