ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require File.dirname(__FILE__) + '/../lib/devourer_of_files'
require 'rspec'

class FakeDataStore
  def get(key)
    data[key]
  end
  
  def set(key, value)
    data[key] = value
  end
  
  def incrby(key, size)
    data[key] += size
  end
  
  def exists(key)
    data.has_key?(key)
  end
  
  private
  def data
    @data ||= {}
    @data
  end
end

class FakeFileStore
  def save(filename, input_stream)
    {}
  end
  
  def url_for(file_id, filename)
    "#{file_id}/#{filename}"
  end
end