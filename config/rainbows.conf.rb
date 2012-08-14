require 'redis'

worker_processes 4
#preload_app true

Rainbows! do
  use :ThreadSpawn
  client_max_body_size 100*1024*1024
  keepalive_requests 666
  client_header_buffer_size 2 * 1024
end

before_fork do |server, worker|
  if defined?(DB)
    DB.quit
  end
  sleep 1
end

after_fork do |server, worker|
  if ENV["REDISTOGO_URL"]
    uri = URI.parse(ENV["REDISTOGO_URL"])
    DB = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
  else
    DB = Redis.new()
  end
end