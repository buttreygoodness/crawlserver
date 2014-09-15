do require('chai').should

config = require "#{process.cwd()}/src/config/express"

describe 'config/express', () ->
  it 'should return an object.', () ->
    config.should.be.an.object