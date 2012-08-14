var IframeUpload = {
  IFRAME_ID: "iframe_for_uploading_file",
  
  uploadFile: function(form) {
    var uploadIframe = IframeUpload._createIframe();

	uploadIframe.load(function(){
      IframeUploadEventHandler.loaded($('#uploaded'));
    });

    IframeUpload._uploadForm(form);
  },

  getUploadIframe: function() {
    return $('#'+IframeUpload.IFRAME_ID);
  },

  deleteIframe: function() {
    var iframe = IframeUpload.getUploadIframe();
    if (iframe) {
      iframe.remove();
    }
  },

  _createIframe: function() {
    var uploadIframe = $('<iframe id="'+IframeUpload.IFRAME_ID+'" name="'+IframeUpload.IFRAME_ID+'" width="0" height="0" border="0" style="width: 0; height: 0; border: none;">');
    uploadIframe.appendTo('body');

    window.frames[IframeUpload.IFRAME_ID].name = IframeUpload.IFRAME_ID;

    return IframeUpload.getUploadIframe();
  },

  _uploadForm: function(form, uid) {
    form.attr('target', IframeUpload.IFRAME_ID);
    form.submit();
  }
};