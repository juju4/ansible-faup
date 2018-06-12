require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

describe file('/usr/local/bin/faup') do
  it { should be_executable }
end

describe command('/usr/local/bin/faup -v') do
  its(:stdout) { should match /faup v/ }
  its(:stdout) { should match /TLD file being used:/ }
  its(:stderr) { should_not match /error while loading shared libraries/ }
  its(:exit_status) { should eq 0 }
end

describe command('/usr/local/bin/faup -f tld slashdot.org') do
  its(:stdout) { should match /org/ }
  its(:exit_status) { should eq 0 }
end

