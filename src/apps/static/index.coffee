htmlFilter = require '../../helpers/htmlFilter'

module.exports = (app) ->
  transport = app.get 'transport'

  filter = app.get 'transport filter'

  ttl = app.get 'cache for'

  if not transport
    return

  Transport = require "../../libs/transport/#{transport}"
    
  app.get '/*', (req, res) ->
    transporter = new Transport

    transporter.get(req.from).then (html) ->
      filtered = htmlFilter html, filter

      req.cache.set req.from, filtered, ttl

      req.log "Cached #{req.from.yellow} for #{ttl}s"

      res.send(filtered).end
