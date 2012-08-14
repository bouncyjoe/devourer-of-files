require 'aws/s3'
require 'yaml'
require 'redis'
require 'yajl'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'devourer_of_files/file_uploader'
require 'devourer_of_files/file_store'
require 'devourer_of_files/models/file'
require 'devourer_of_files/controllers/files'
require 'devourer_of_files/app'

module DevourerOfFiles
  EC2_CONFIG = YAML::load(File.read(File.dirname(__FILE__) + '/../config/ec2.yml'))[ENV['RACK_ENV']]
  AWS::S3::DEFAULT_HOST = EC2_CONFIG['host']
  
  if ENV["REDISTOGO_URL"]
    uri = URI.parse(ENV["REDISTOGO_URL"])
    DB = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  else
    DB = Redis.new()
  end
end