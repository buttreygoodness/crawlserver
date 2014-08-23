var express = require('express');
var request = require('request');
var app = express();
var PORT = process.env.PORT || 8888;

var sendContent = function (url, res) {

  if (/\.js/.test(url)) {
    res.send('var fake=true;');
    return;
  }

  request(url, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      res.send(body);
    }
  });

};

var getContent = function(url, req, callback) {
  console.log('User-Agent: ' + req.headers['user-agent'] + ' URL: ' + url);

  var content = '';
  // Here we spawn a phantom.js process, the first element of the 
  // array is our phantomjs script and the second element is our url 
  var phantom = require('child_process').spawn('phantomjs', ['phantom-server.js', url, '--config=' + process.cwd() + 'config.json']);

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
  url = 'http://' + webhost + req.params[0];

  if (/^\/assets\/.*/.test(req.params[0])) {
    return sendContent(url, res);
  }

  getContent(url, req, function (content) {
    res.send(content);
  });
}

console.log('crawlserver listening on port ' + PORT);

app.get(/(.*)/, respond);
app.listen(PORT);