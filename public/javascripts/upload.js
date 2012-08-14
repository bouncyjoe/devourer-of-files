Upload = {
  file: function(filename, uploadForm, uid){
    if(Upload._useIframeUploading()){
      IframeUpload.uploadFile(uploadForm, uid); 
    }
    else{
      var formData = new FormData(uploadForm[0]);
      $.ajax({url: '/files?file_id='+uid,
              type: 'POST',
              data: formData,
              beforeStart: UploadEventHandler.start,
              success: UploadEventHandler.complete,
              error: UploadEventHandler.error,
              cache: false,
              contentType: false,
              processData: false,
              headers: {'X-File-Name': filename}});
    }
  },
  
  generateUid: function(){
    var uid;
    $.ajax({'url': '/files/id',
        cache: false,
        contentType: false,
        processData: false,
        async: false,
        type: 'GET',
        success: function(response){
          uid = response;
        }
      });
    return uid;
  },

  extractFilename: function (filenameWithPath){
    return filenameWithPath.substr(filenameWithPath.lastIndexOf('\\') + 1);
  },
  
  _useIframeUploading: function (){
    return ! window.FormData;
  } 
}