describe("IframeUploadEventHandler", function() {  
  afterEach(function(){
    $('#fake_iframe').remove();
  });

  function fake_iframe_with_content(content){
   var iframe = $('<iframe id="fake_iframe"></iframe');
   iframe.appendTo('body');
   iframe.contents().find('html').html(content);
   return iframe;
  }
  
  describe("with a successful upload", function(){  
    it ("should set target to a link to the returned file url", function() {
     var target = $('<div></div>');

     spyOn(IframeUpload, 'getUploadIframe').andReturn(fake_iframe_with_content('{"url": "http://fake/file.png"}'));
   
     IframeUploadEventHandler.loaded(target);

     expect(target.html()).toEqual('<a href="http://fake/file.png">http://fake/file.png</a>');
    });
  });

  describe("with a failed upload", function(){  
    it ("should set target to error", function() {
     var target = $('<div></div>');

	 spyOn(IframeUpload, 'getUploadIframe').andReturn(fake_iframe_with_content('{"error": "oh pants"}'));
   
     IframeUploadEventHandler.loaded(target);

     expect(target.html()).toEqual('Sorry, there was a problem uploading your file.');
    });
  });
});