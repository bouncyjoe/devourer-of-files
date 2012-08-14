ProgressEventHandler = {
  start: function(fileId, target){
    var success = function(response){
        target.html(response + '%');
        if(response != "100"){
          setTimeout(function(){
           ProgressEventHandler.start(fileId, target); 
          }, (2 * 1000));
        }
    };
    
    $.ajax({
      url: '/files/progress?file_id='+fileId,
      success: success,
      cache: false,
      type: 'GET',
      contentType: false,
      processData: false
    });
  }
};