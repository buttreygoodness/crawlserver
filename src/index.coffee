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
      do @_bind
      do @_mount

    start: (port) ->
      @app.set 'port', port or @app.get 'port'

      @app.listen @app.get 'port'

    _populateOptions: () ->
      for key, value of @options
        @app.set key, value

    _bind: () ->
      @app.on 'listening', () ->
        console.log ':)'

    _mount: () ->
      routes @app