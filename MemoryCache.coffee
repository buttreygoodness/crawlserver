Car             = require "car"
AbstractStorage = Car.storage.AbstractStorage

module.exports =

  class MemoryCache extends AbstractStorage

    constructor: () ->
      @_cache = {}

    get: (key, callback) ->
      if @_cache[key]?
        result = 
          if @_cache[key].expires < Date.now()
            console.log 'expires'
            null
          else
            @_cache[key].body

      callback null, result

    set: (key, value, ttl, callback) ->
      @_cache[key] = 
        expires: Date.now() + ttl
        body: value

      do callback

    destroy: (key, callback) ->
      delete @_cache[key]

      do callback

    flush: (callback) ->
      @_cache = {}

      do callback