require 'securerandom'

module DevourerOfFiles
  module Files
    class InvalidFileId < Exception; end
    class InvalidFilesize < Exception; end
    class InvalidFilename < Exception; end
    
    class New
      def self.run
        view = File.read("#{App::VIEWS_DIR}/new.html")
        [200, {"Content-Type" => "text/html"}, [view]] 
      end
    end
  
    class Show
      def self.run(file_id)
        return unless file_id && !file_id.empty?
      
        file_store = FileStore.new
        file = Models::File.find(file_id)
        content = [file.description, " ", "<a href=\"#{file_store.url_for(file.file_id, file.filename)}\">#{file_store.url_for(file.file_id, file.filename)}</a>"]

        [200, {"Content-Type" => "text/html"}, content]
      end
    end
  
    class Create
      def self.run(params)
        return unless params['filename'] && params['input_stream'] && params['filesize'] && params['file_id']
        
        raise InvalidFileId.new("Invalid file id, cannot upload file") if params['file_id'].empty?
        raise InvalidFilename.new("Invalid file name, cannot upload file") if params['filename'].empty?
        raise InvalidFilesize.new("Filesize cannot be zero") unless params['filesize'] != 0
      
        Models::File.create(params['file_id'], params['filename'])
      
        uploader = FileUploader.new
        file_url = uploader.upload(params['file_id'], params)

        [200, {"Content-Type" => "text/html"}, [Yajl::Encoder.encode({'url' => file_url})]]
      end    
    end
  
    class Update
      def self.run(file_id, params)
        return unless file_id && !file_id.empty? && params.has_key?('description')
      
        file = Models::File.find(file_id)
        file.update(:description => params['description'])

        [303, {'Location' => "/files?file_id=#{file_id}"}, ['']]
      end
    end
  
    class Progress
      def self.run(file_id)
        return unless file_id && !file_id.empty?
      
        uploader = FileUploader.new
        progress = uploader.progress(file_id)

        [200, {"Content-Type" => "text/html"}, [progress.to_s]]
      end
    end 
    
    class Guid
      def self.run
        [200, {"Content-Type" => "text/html"}, [SecureRandom.uuid().gsub('-','')]]
      end
    end 
    
  end
end