_   = require 'lodash'
car = require 'car'

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
          do res.send(result).end
        else
          do next
