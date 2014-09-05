_ = require 'underscore'
express = require 'express'
MemoryCache = require './MemoryCache'
PORT = process.env.PORT or 8888
request = require 'request'
WEBHOST = process.env.webhost || 'local.host:3000'

app = do express
mc = new MemoryCache

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

  mc.get req.path, (exists, cached) ->
    if cached then return res.send cached

    if /css|js|txt|png|ico$/.test url
      return request url, (err, response, body) ->
        mc.set req.path, body, 1000000, () ->
          res.send body

    else
      return getContent url, (html) ->
        mc.set req.path, html, 1000000, () ->
          res.send html


console.log 'crawlserver listening on port ' + PORT

app.get /(.*)/, respond
app.listen PORT