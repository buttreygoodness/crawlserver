var express = require('express');
var app = express();
var PORT = process.env.PORT || 8888;

var getContent = function(url, callback) {

  var content = '';
  // Here we spawn a phantom.js process, the first element of the 
  // array is our phantomjs script and the second element is our url 
  var phantom = require('child_process').spawn('phantomjs', ['phantom-server.js', url]);

  phantom.stdout.setEncoding('utf8');
  // Our phantom.js script is simply logging the output and
  // we access it here through stdout
  phantom.stdout.on('data', function(data) {
    content += data.toString();
  });
  phantom.on('exit', function(code) {
    if (code !== 0) {
      console.log('We have an error');
    } else {
      // once our phantom.js script exits, let's call out call back
      // which outputs the contents to the page
      callback(content);
    }
  });
};

var respond = function (req, res) {
  var webhost = process.env.webhost || 'local.host:3000'; 
  // Because we use [P] in htaccess we have access to this header
  url = 'http://' + webhost + req.params[0];
  getContent(url, function (content) {
    res.send(content);
  });
}

console.log('crawlserver listening on port ' + PORT);

app.get(/(.*)/, respond);
app.listen(PORT);