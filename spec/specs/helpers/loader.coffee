do require('chai').should

loader = require "#{process.cwd()}/src/helpers/loader"

describe 'helpers/loader', () ->
  target = null

  beforeEach () ->
    target = {}

  it 'should apply arguments to loaded module.', () ->
    loader "#{process.cwd()}/spec/fixtures/helpers/loader/1.coffee", target

    target.should.have.property '1', true

  it 'should accept globs.', () ->
    loader "#{process.cwd()}/spec/fixtures/helpers/loader/*.coffee", target
    
    target.should.have.property '1', true
    target.should.have.property '2', true

  it 'should accept an array of globs.', () ->
    loader [
      "#{process.cwd()}/spec/fixtures/helpers/loader/*.js"
      "#{process.cwd()}/spec/fixtures/helpers/loader/*.coffee",
    ], target

    target.should.have.property '1', true
    target.should.have.property '2', true
