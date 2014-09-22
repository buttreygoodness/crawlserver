process = require 'child_process'

Transport = require '../Transport'

module.exports =

  class CasperTransport extends Transport

    _process: (request, callback) ->
      html = ''

      casper = process.spawn 'casperjs', [
        "#{__dirname}/casper.coffee",
        "--request=#{request}"
      ]

      casper.stdout.on 'data', (data) ->
        html += do data.toString

      casper.on 'exit', (code) ->
        if code isnt 0
          callback code
        else
          callback null, html

    _get: (request, callback) ->
      @_process request, callback
