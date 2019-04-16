# Inspec test for recipe sfmc_keepalived::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('keepalived') do
  it { should be_installed }
end
describe service('keepalived') do
  it { should be_enabled }
  it { should be_running }
end

