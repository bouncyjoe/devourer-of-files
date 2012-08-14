module DevourerOfFiles
  module Models
    
    class File
      def initialize(file_id, store = DB)
        @file_id = file_id
        @store = store
      end
      
      def self.create(file_id, filename)
        new(file_id).create(filename)
      end
      
      def self.find(file_id)
        new(file_id)
      end
  
      def create(filename)
        @store.set(filename_key, filename)
      end
    
      def file_id
        @file_id
      end
  
      def description
        @decription ||= @store.get(description_key)
      end
      
      def filename
        @filename ||= @store.get(filename_key)
      end
  
      def update(fields = {})
        return unless fields[:description]
        @store.set(description_key, fields[:description])
      end

      private
      def description_key
        "#{@file_id}:description"
      end

      def filename_key
        "#{@file_id}:filename"
      end
    end
    
  end
end