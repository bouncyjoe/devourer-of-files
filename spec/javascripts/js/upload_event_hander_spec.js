describe("UploadEventHandler", function() {
  describe("#start", function(){
    it("should default the progress to 0%", function() {
	  var target = $('<div id="progress"><span id="percentage"></div>');
      target.appendTo('body');

      UploadEventHandler.start();
	 
      expect($('#progress #percentage').html()).toEqual("0%");
    });
  });

  describe("#complete", function(){
    it("should set progress to 100%", function() {
	  var target = $('<div id="progress"><span id="percentage"></div>');
      target.appendTo('body');

      var response = '{"url": "http://wombles"}';
      UploadEventHandler.complete(response);
	 
      expect($('#progress #percentage').html()).toEqual("100%");
    });
  });
  
  describe("error with json information about failure", function(){
    it("should show the error messager", function() {
      var target = $('<div id="errors"></div>');
      target.appendTo('body');

      var response = {'responseText': '{"error":"oh dearey me"}'}

      UploadEventHandler.error(response);
	 
      expect($('#errors').html()).toEqual("oh dearey me");
    });
  });

  describe("error without any json to tell us why", function(){
    it("should shows me the generic error messager", function() {
      var target = $('<div id="errors"></div>');
      target.appendTo('body');
  
      var response = {'responseText': '{}'}
  
      UploadEventHandler.error(response);
     
      expect($('#errors').html()).toEqual("Sorry, there was a problem with your download");
    });
  });

  
});
