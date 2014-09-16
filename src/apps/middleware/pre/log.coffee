module.exports = (app) ->
  log = app.get 'log'

  app.use (req, res, next) ->
    req.log = log

    do next