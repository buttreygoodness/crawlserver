_ = require 'underscore'
car = require 'car'
cheerio = require 'cheerio'
express = require 'express'
request = require 'request'

PORT = process.env.PORT or 8888
WEBHOST = process.env.webhost || 'local.host:3000'

cache = car.cache 'Memory'
app = do express

getContent = (url, callback) ->

  content = ''
  phantom = require 'child_process' 
    .spawn 'phantomjs', ['phantom-server.js', url, '--config=' + process.cwd() + 'config.json']

  phantom.stdout.setEncoding 'utf-8'

  phantom.stdout.on 'data', (data) ->
    content += data.toString()

  phantom.on 'exit', (code) ->
    if code != 0
      console.log 'we have an error'
    else
      callback content

respond = (req, res) ->

  url = 'http://' + WEBHOST + req.params[0]
  
  cache.get req.path
  .then (cached) ->

    console.log req.path + ' -> ' + req.headers['user-agent']

    return res.send cached if cached

    if /css|js|txt|png|ico|gif|jpg|woff|ttf|svg|xml$/.test url
      request url, (err, response, body) ->
        cache.set(req.path, body, 36000).then () ->
          res.send(body).end()
    else
      getContent url, (html) ->
        $ = cheerio.load html
        do $('script').remove
        
        htmlCache = $.html()

        cache.set(req.path, htmlCache, 36000).then () ->
          res.send(htmlCache).end()

console.log 'crawlserver listening on port ' + PORT

app.get /(.*)/, respond
app.listen PORT