loader = require '../helpers/loader'

module.exports = (app) ->
  loader [
    "#{__dirname}/middleware/pre/*.coffee"
    "#{__dirname}/middleware/*.coffee",
    "#{__dirname}/!(middleware)/index.coffee"
  ], app