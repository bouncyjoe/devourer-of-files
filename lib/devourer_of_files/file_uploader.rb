module DevourerOfFiles
  
  class FileUploader
    NUMBER_OF_BYTES_TO_READ = 1024 * 5
    
    def initialize(data_store = DB, file_store = FileStore.new)
      @data_store = data_store
      @file_store = file_store
    end
    
    def upload(file_id, file_data)
      bytes_read = 0
      
      while data = file_data['input_stream'].read(NUMBER_OF_BYTES_TO_READ)
        bytes_read += data.size
        percent = percentage_completion(file_data['filesize'], bytes_read)
        @data_store.set(file_id, percent)
      end
      
      @file_store.save("#{file_id}/#{file_data['filename']}", extract_tmp_file(file_data))
      @file_store.url_for(file_id, file_data['filename'])
    end
    
    def progress(file_id)
      if @data_store.exists(file_id)
        @data_store.get(file_id)
      else
        0
      end
    end
    
    private
    def extract_tmp_file(file_data)
      file_data['request']['file'][:tempfile]
    end
    
    def percentage_completion(filesize, processed_bytes)
      ((processed_bytes / filesize.to_f) * 100).ceil
    end
  end
  
end