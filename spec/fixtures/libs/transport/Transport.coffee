Transport = require "#{process.cwd()}/src/libs/transport/Transport"

module.exports = (status = 'pass') ->

  class Fixture extends Transport

    _get: (resource, callback) ->
      if status is 'pass'
        callback null, 'pass'
      else
        callback 'fail'

  new Fixture
  