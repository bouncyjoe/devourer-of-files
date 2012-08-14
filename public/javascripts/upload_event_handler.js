var UploadEventHandler = {
  start: function(){
    UploadEventHandler._updateProgressBar('0');
    $('#uploaded').html('');
    $('#progress').fadeIn();
  },
    
  error: function(response){
    error_response = $.parseJSON(response.responseText);
    if(error_response && error_response.error){
      $('#errors').html(error_response.error);
    }
    else{
      $('#errors').html("Sorry, there was a problem with your download");
    }
  },

  complete: function(response){
	data = $.parseJSON(response);
	  
    UploadEventHandler._updateProgressBar('100')
    $('#uploaded').html("<a href="+data['url']+">"+ data['url'] +"</a>")
  },

  _updateProgressBar: function(percent){
    $('#progress #percentage').html(percent + '%');
  }
};