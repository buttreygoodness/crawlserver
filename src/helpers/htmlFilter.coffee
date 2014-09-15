_       = require 'lodash'
cheerio = require 'cheerio'

module.exports = (html, selectors = []) ->
  $ = cheerio.load html

  if _.isString selectors
    selectors = [selectors]

  _.each selectors, (selector) ->
    do $(selector).remove

  do $.html