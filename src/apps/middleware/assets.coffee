path    = require 'path'
request = require 'request'

module.exports = (app) ->
  capture = app.get 'assets capture'

  app.use (req, res, next) ->
    extension = path.extname req.path

    if capture.indexOf(extension) isnt -1
      do next
    else
      request(req.from).pipe res
