describe("IframeUpload", function() {
  beforeEach(function () {
     $('.'+IframeUpload.IFRAME_ID).remove();
  });

  afterEach(function () {
     $('.'+IframeUpload.IFRAME_ID).remove();
  });
  
  describe("#uploadFile", function() {
    it ("should append a new iframe to the document", function() {
     var form = $('<div></div>');

     expect(IframeUpload.getUploadIframe()[0]).toBeUndefined();

     IframeUpload.uploadFile(form);
   
     expect(IframeUpload.getUploadIframe()[0]).toBeDefined();
    }),
    
    it ("should set the target of the passed form to the iframes id", function() {
      var form = $('<div></div>');
      IframeUpload.uploadFile(form);
   
      expect(form.attr('target')).toEqual(IframeUpload.IFRAME_ID);
    }),
    
    it ("should submit the form", function() {
      var form = $('<div></div>');
      spyOn(form, 'submit');

      IframeUpload.uploadFile(form);
   
      expect(form.submit).toHaveBeenCalled();
    });
    
  });
});