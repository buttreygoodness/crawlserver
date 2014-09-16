_       = require 'lodash'
car     = require 'car'
colors  = require 'colors'

module.exports = (app) ->
  cache = app.get 'cache'

  engine =
    if _.isString cache
      car.cache cache

  if not engine
    return

  app.use (req, res, next) ->
    req.cache = engine

    req.cache.get req.from
      .then (result) ->
        if result
          req.log "Cache Hit on #{req.from.yellow}"

          do res.send(result).end
        else
          req.log "Cache Miss on #{req.from.yellow}"

          do next
