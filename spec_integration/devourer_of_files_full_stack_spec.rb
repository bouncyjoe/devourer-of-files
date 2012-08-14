require File.dirname(__FILE__) + '/spec_helper'

describe "Devourer of Files application", :type => :full_stack do
  it "should let me attach a file for uploading" do
    visit '/'
    attach_file('file', File.dirname(__FILE__) + '/fixtures/soundcloud.png')
  end
end