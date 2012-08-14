module DevourerOfFiles
    
  class FileStore
    UPLOAD_DIR = ::File.dirname(__FILE__) + "/../../public/upload"
      
    def initialize(config = EC2_CONFIG)
      @config = config
    end
        
    def save(filename, input_stream)
      return unless filename && input_stream
        
      begin
        connect_to_file_store
        AWS::S3::S3Object.store(filename, input_stream, bucket, :access => :public_read)
      rescue Exception => e
        raise "Problem uploading to S3 #{e}"
      end
    end

    def url_for(file_id, filename)
      "http://#{AWS::S3::DEFAULT_HOST}/#{bucket}/#{file_id}/#{filename}"
    end
   
    private
    def bucket
      @config['bucket']
    end
    
    def connect_to_file_store
      AWS::S3::Base.establish_connection!(:access_key_id     => @config['s3_key'],
                                          :secret_access_key => @config['s3_secret'])
    end
  end
    
end