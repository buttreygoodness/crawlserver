Q = require 'q'

module.exports =
  
  class Transport

    constructor: (@options = {}) ->
      @_requests = {}

    get: (resource) ->
      if @_requests[resource]?
        return @_requests[resource]

      request = do Q.defer

      @_requests[resource] = request.promise

      @_get resource, do request.makeNodeResolver

      @_requests[resource]

    _get: (resource, callback) ->
      throw new Error '_get is unimplemented.'

