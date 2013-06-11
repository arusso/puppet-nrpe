require 'rake'

begin
  require 'rspec/core/rake_task'
  require 'puppet-lint/tasks/puppet-lint'
rescue
  require 'rubygems'
  retry
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

task :test => [:spec]

task :default => :test
