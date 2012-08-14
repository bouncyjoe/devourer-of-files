require 'spec_helper'

module DevourerOfFiles
  describe FileStore do
    context "missing file or input stream" do
      it "should not create a connection to AWS" do
        file_store = FileStore.new
      
        AWS::S3::Base.should_not_receive(:establish_connection)
      
        file_store.save(nil, mock('input_stream'))
      end
    
      it "should not try and store the file" do
        file_store = FileStore.new

        AWS::S3::S3Object.should_not_receive(:store)
      
        file_store.save('soundcloud.png', nil)
      end
    end
  end
end