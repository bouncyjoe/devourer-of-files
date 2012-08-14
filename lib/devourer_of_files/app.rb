module DevourerOfFiles

  class App
    VIEWS_DIR = File.dirname(__FILE__) + '/../../views'
    
    def initialize(app = nil)
      @app = app
    end

    def call(env)
      @request = Rack::Request.new(env)
      return public_assets if public_assets_request?
      
      response = case [@request.path, @request.request_method]
      when ['/', 'GET']
        Files::New.run
      when ['/files', 'GET']
        Files::Show.run(file_id)
      when ['/files', 'POST']
        params = {'filename' => filename,
                  'filesize' => filesize,
                  'file_id' => file_id,
                  'input_stream' => input_stream,
                  'request' => @request}
                  
        Files::Create.run(params)
      when ['/files/progress', 'GET']
        Files::Progress.run(file_id)
      when ['/files/update', 'POST']
        DB.set('logging', "update #{@request.params} #{file_id} #{env}")
        Files::Update.run(file_id, @request.params)
      when ['/files/id', 'GET']
        Files::Guid.run
      end
      
      response && response.kind_of?(Array) ? response : not_found_response
    rescue Exception => e
      error_response(e)
    end

    private
    def public_assets_request?
      @request.path =~  /^\/stylesheets/ || @request.path =~ /^\/javascripts/ || @request.path == '/favicon.ico'
    end
    
    def public_assets
      asset_file = File.dirname(__FILE__) + "/../../public/#{@request.path}"
      return not_found_response unless File.exists?(asset_file)
      
      type =  File.extname(asset_file)
      [200, {"Content-Type" => Rack::Mime.mime_type(type)}, [File.read(asset_file)]] 
    end
    
    def error_response(error)
      response = {:error => error.to_s,
                  :backtrace => error.backtrace.join("\n")}
      
      [500, {"Content-Type" => "text/html"}, [Yajl::Encoder.encode(response)]]
    end
    
    def not_found_response
      [404, {"Content-Type" => "text/html"}, []]
    end
        
    def input_stream
      @request.env['rack.input']
    end
      
    def file_id
      Rack::Utils.parse_query(@request.env['QUERY_STRING'])['file_id'] || @request.params["file_id"]
    end
      
    def filename
      @request.env["HTTP_X_FILE_NAME"] || @request.params["HTTP_X_FILE_NAME"] || @request.params['filename']
    end
    
    def filesize
      @request.env["CONTENT_LENGTH"].to_i
    end
  end
  
end