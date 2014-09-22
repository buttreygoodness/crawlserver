module.exports = (app) ->
  from = app.get 'transport from'

  app.use (req, res, next) ->
    req.from = "#{from}#{req.path}"

    do next