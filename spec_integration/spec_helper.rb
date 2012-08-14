ENV['RACK_ENV'] = 'test'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rspec'
require 'rack/test'
require 'capybara/dsl'
require 'capybara/rspec'

require 'fakeweb'
FakeWeb.allow_net_connect = false;

require 'simplecov'
SimpleCov.start

require 'devourer_of_files'

Capybara.app = DevourerOfFiles::App.new

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL, :type => :full_stack
  
  def app
    DevourerOfFiles::App.new
  end
  
  def body
    last_response.body
  end
  
  config.before(:all) do
    DevourerOfFiles::DB.flushdb
  end
  
end