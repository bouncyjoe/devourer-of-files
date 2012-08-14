require 'spec_helper'

module DevourerOfFiles
  describe FileUploader do
    let(:fake_data_store){ FakeDataStore.new }
    let(:fake_file_store){ FakeFileStore.new }
    
    let(:fake_input_stream) do 
      input_stream_fake = double('input stream', :size => 1024) 
      input_stream_fake.stub!(:read).and_return('1'*1024, nil)
      input_stream_fake
    end
    
    def file_data(options = {})
      {'filename' => 'soundcloud.png',
       'filesize' => 1024,
       'input_stream' => fake_input_stream,
       'request' => {'file' => {:tempfile => mock('tmpfile')}}}.merge(options)
    end
    
    describe "#upload" do
      it "should store the progress of the upload" do
        file_uploader = FileUploader.new(fake_data_store, fake_file_store)
        
        file_uploader.upload('1234', file_data)
        
        fake_data_store.get('1234').should == 100
      end
      
      it "should upload the file to S3" do
        file_uploader = FileUploader.new(fake_data_store, fake_file_store)
        
        file_uploader.upload('1234', file_data)
      end
      
      it "should return the url to the file on S3" do
        file_uploader = FileUploader.new(fake_data_store, fake_file_store)
        
        file_uploader.upload('1234', file_data)
      end
    end
  
    describe "#progress" do
      it "should always return 0% if the file has not been uploaded" do
        file_uploader = FileUploader.new(fake_data_store, fake_file_store)
        
        progress = file_uploader.progress('soundcloud.png')
        
        progress.should == 0
      end
      
      it "should return 100% when the file has been uploaded" do
        file_uploader = FileUploader.new(fake_data_store, fake_file_store)
        file_uploader.upload('1234', file_data)
        
        progress = file_uploader.progress('1234')
        
        progress.should == 100
      end
      
    end
  end
end