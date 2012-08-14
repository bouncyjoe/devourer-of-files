require File.dirname(__FILE__) + '/spec_helper'

describe "Devourer of Files server" do
    it "should return a 404" do
      get '/monkeymagic'
    end
  
  describe "responding to POST /file" do
    before(:each) do
      FakeWeb.register_uri(:put, "http://s3-eu-west-1.amazonaws.com/devourer-of-files-test/1234/soundcloud.png", :body => "")
    end
    
    it "should return a link to the file" do
      test_file = Rack::Test::UploadedFile.new(File.dirname(__FILE__) + "/fixtures/soundcloud.png", "image/png")

      post '/files?file_id=1234', :file => test_file, 'HTTP_X_FILE_NAME' => "soundcloud.png"
      
      body.should include "http://s3-eu-west-1.amazonaws.com/devourer-of-files-test/1234/soundcloud.png"
    end
  end

  describe "responding to GET /progress" do
    context "with a file which has never been uploaded" do
      it "should return 0% progress" do
        get '/files/progress', :file_id => '19191919'
      
        body.should == "0"
      end
    end    
    
    context "with an uploaded file" do
      it "should return progress of a file upload" do
        test_file = Rack::Test::UploadedFile.new(File.dirname(__FILE__) + "/fixtures/soundcloud.png", "image/png")
    
        post '/files', :file => test_file, :file_id => '1234'
      
        get '/files/progress', :file_id => '1234'
      
        body.should_not == "0"
      end
    end
  end
  
  describe "responding to POST /file/update" do
    it "should update the description of the file" do
      post '/files/update', {'file_id' => '1234', 'description' => 'lovely stuff'}
      
      get '/files', 'file_id' => '1234'
      
      body.should =~ /lovely stuff/
    end
  end
  
  describe "responding to GET /files/id" do
    it "should return a uid" do
      get '/files/id'
      
      body.should_not == ""
    end
  end
  
end