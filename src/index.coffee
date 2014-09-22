_       = require 'lodash'
colors  = require 'colors'
express = require 'express'

routes = require './apps'

defaults = require './config/express'

module.exports =

  class Server

    constructor: (options = {}, app) ->
      @options =
        if options.defaults is false
          _.merge {}, options
        else
          _.merge {}, defaults, options

      @app = app or do express

      do @_populateOptions
      do @_mount

    listen: (port) ->
      @app.set 'port', port or @app.get 'port'

      server = @app.listen @app.get 'port'

      @_bindServer server

      server

    _mount: () ->
      routes @app

    _populateOptions: () ->
      for key, value of @options
        @app.set key, value

    _bindServer: (server) ->
      self = @

      server.on 'listening', () ->
        console.log "Crawlserver running on port: #{self.app.get('port').toString().green}"

