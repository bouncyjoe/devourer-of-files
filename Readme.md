#Devourer of Files

Demo: http://devourer-of-files.herokuapp.com/

A Ruby webapp written on top of Rack for uploading files. Supports Chrome, Firefox, IE 7.

Uses an iframe based approach for older browsers (I'm looking at you IE).

This app does not use the client side support for progress handling. While tempting to remove work from the server I found it unreliable. 
Hence irrelevant of the browser, progress is achieved through polling the the server.

To avoid any nasty conflicts in file upload progress or file storage a UID is generated for each file upload.

#Dependencies

* Web server: Rainbows / Rack
* Persistance store: Redis
* File storage: AWS-s3
* Client Side: JQuery

####Rainbows / Webserver
Based on unicorn but designed for long running tasks like file uploads. Unicorn is a familiar friend when its comes to high performance traffic. So I thought I would give its Rainbows cousin a try. 

The app is written on top of Rack to minimise dependencies. Which was fun as it allowed the app to take shape rather than be forced by a framework.

My pet peeve with the design is passing in the request object to the FileUploader so it can grab the tmpfile. Having tried to keep separation of the actions/controllers and the rack requests this broken that encapsulation. It however provided an expedient way to to skip dealing with binary data processing with S3.

#### Redis / Persistence store:
Since Rainbows forks a new process for each worker there is no shared state. Hence we need a persistence store to record progress of uploaded files. We also use this to store descriptions of files and filenames. No particularly overwhelming reason for using Redis over something else. It just did the job.
 
#### S3 / File store:
I always prefer pushing file storage to a cloud service rather than leaving files on the webserver. This also means I could host the app on Heroku, since we are not allowed to write disk. The downside of this decisions is you have to wait for the file to be uploaded twice (once to the server and then to S3). We can stream to S3 but the smallest possible upload chunk is 5mb. To keep it simple I just upload the file to S3 without streaming. Using S3 means there can be delays in the UI. We see the progress reaching 100% but then we have to wait for the upload to S3 before the file url can be shown (well, we could lie since we already know the url on s3... but thats evilish). Ideally we would push files from the webserver into the cloud in a background task. But in this example I wanted to keep the code simple and not deal with multiple apps needing to be run. Hence once the files have been uploaded they are pushed to S3.

If your paying attention you might have noticed I've pushed my S3 api secret config information! These keys will be short lived.

#### JQuery
Trying to add support for browsers like IE gets messy. JQuery provided a nice bit of abstraction over the messy different ways browsers do things.

# Testing

In order to run the Javascript unit tests you need to have phantom.js installed (http://phantomjs.org/download.html).

If you into your brew a quick install is possible:
<pre><code>brew install phantom.js</code></pre>

To run the:
* Unit tests
* Js unit tests
* Integration tests

all you need to do is run:

<pre><code>rake</code></pre>

Thats it!