require File.dirname(__FILE__) + '/lib/devourer_of_files'

use Rack::ContentLength
run DevourerOfFiles::App.new