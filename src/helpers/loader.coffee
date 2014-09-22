_     = require 'lodash'
glob  = require 'glob'

load = (search, args...) ->
  if _.isArray search
    _.each search, (match) ->
      load.apply null, [match].concat args
  
  else
    files = glob.sync search

    _.each files, (file) ->
      module = require file

      if _.isFunction module
        module.apply null, args

module.exports = load