htmlFilter = require '../../helpers/htmlFilter'

module.exports = (app) ->
  transport = app.get 'transport'

  filter = app.get 'transport filter'

  if not transport
    return

  Transport = require "../../libs/transport/#{transport}"
    
  app.get '/*', (req, res) ->
    transporter = new Transport

    transporter.get(req.from).then (html) ->
      filtered = htmlFilter html, filter

      req.cache.set req.from, filtered, 3600

      res.send(filtered).end
