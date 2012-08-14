IframeUploadEventHandler = {
  loaded: function(target) {
    var uploadIframe = IframeUpload.getUploadIframe();

    IframeUploadEventHandler._detach(uploadIframe);
    
    var response = IframeUploadEventHandler._content(uploadIframe);
    if(response.error){
      IframeUploadEventHandler.error(response, target);
    }
    else{
      IframeUploadEventHandler.success(response, target);
    }
  },
  
  success: function(response, target){
    var url = response['url'];

    target.html("<a href=" + url + ">" + url + "</a>");
    setTimeout('IframeUpload.deleteIframe()', 250);    
  },
  
  error: function(error, target){
    target.html("Sorry, there was a problem uploading your file.");
  },

  _content: function(uploadIframe) {
    var content = uploadIframe.contents().find("body").html();
    return $.parseJSON(content);
  },

  _detach: function(uploadIframe) {
    uploadIframe.unbind('onload');
  }
}
