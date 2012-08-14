require 'spec_helper'

module DevourerOfFiles
  module Files
    
    describe "Validation" do
      describe Show do
        it "should do nothing if file_id is nil" do
          Show.run(nil).should == nil
        end
      end  
      
      describe Create do
        def create_params(attributes = {})
          {'filename' => 'soundcloud.png',
            'filesize' => '100',
            'file_id' =>  '1234',
            'input_stream' => 'file'}.merge(attributes)
        end
        
        it "should do nothing if there is not a file_id, filename, input_stream and a filesize" do
          [create_params('filename' => nil, 'filesize' => nil, 'file_id' => nil, 'input_stream' => nil),
           create_params('filename' => nil, 'filesize' => nil, 'file_id' => nil),
           create_params('filename' => nil, 'filesize' => nil),
           create_params('filename' => nil)
          ].each do |params_set|
            Create.run(params_set).should == nil
          end
        end
        
        context "with a empty or nil filename" do
          it "should raise an invalid file error" do
            lambda{
               Create.run(create_params('filename' => ''))
            }.should raise_error(InvalidFilename)
          end
        end
        
        context "with a empty or nil file_id" do
          it "should raise an invalid file error" do
            lambda{
               Create.run(create_params('file_id' => ''))
            }.should raise_error(InvalidFileId)
          end
        end
        
        context "with a 0 filesize" do
          it "should raise a invalid file size error" do
            lambda{
              Create.run(create_params('filesize' => 0))
            }.should raise_error(InvalidFilesize)
          end
        end
      end
      
      describe Update do
        it "should do nothing if there is not a file_id and a description" do
          Update.run(nil, {'blah' => :blah}).should == nil
          Update.run(nil, {'description' => 'blah'}).should == nil
          Update.run('12345', {'whatever' => 'blah'}).should == nil
        end
      end
      
      describe Progress do
        it "should do nothing if there is not a file_id" do
          Progress.run(nil).should == nil
        end
      end
      
    end
    
  end
end
