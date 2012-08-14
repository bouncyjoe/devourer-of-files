require 'rspec/core/rake_task'

desc "javascript unit tests"
task :js_unit_tests do
  sh 'phantomjs spec/javascripts/support/run_jasmine_test.coffee spec/javascripts/TestRunner.html'
end

desc "integration tests"
RSpec::Core::RakeTask.new(:spec_integration) do |t|
  t.pattern = 'spec_integration/*'
  t.rcov_opts =  %[-Ilib -Ispec --sort coverage --aggregate coverage.data]
end

desc "unit tests"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*'
  t.rcov_opts =  %[-Ilib -Ispec  --sort coverage --aggregate coverage.data]
end

task :default => [:spec, :js_unit_tests, :spec_integration]