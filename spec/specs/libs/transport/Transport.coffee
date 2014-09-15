do require('chai').should

Transport = require "#{process.cwd()}/src/libs/transport/Transport"

fixture = require "#{process.cwd()}/spec/fixtures/libs/transport/Transport"

describe 'libs/transport/Transport', () ->
  transport = null
  
  beforeEach () ->
    transport = do fixture

  describe 'get', () ->
    it 'should throw if _get is not defined.', () ->
      transport = new Transport

      transport.get.should.throw

    it 'should return a promise.', () ->
      promise = do transport.get

      promise.should.have.property 'then'

    it 'should resolve with a body.', (done) ->
      promise = do transport.get

      promise.then (body) ->
        body.should.equal 'pass'

        do done

    it 'should reject on error.', (done) ->
      transport = fixture 'fail'

      promise = do transport.get
      
      promise.fail (error) ->
        error.should.equal 'fail'

        do done

