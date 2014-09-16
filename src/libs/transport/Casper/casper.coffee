Casper = require 'casper'
system = require 'system'

MAX_TIMEOUT = 10000

POLL_TIMEOUT = 500

casper = do Casper.create

requests = 
  _timeout: null

  _requestIDs: []

  _requests: 0

  _responses: 0

  disarm: () ->
    clearTimeout @_timeout if @_timeout?

  arm: () ->
    @_timeout = setTimeout () ->
      casper.emit 'requests.done'
    , POLL_TIMEOUT 

  request: (resource) ->
    @_requestIDs.push resource.url

    @_requests += 1

    do @disarm

  resolve: (resource) ->
    index = @_requestIDs.indexOf resource.url

    return if index is -1

    @_responses += 1

    @_requestIDs[index] = null

    do @arm if @_requests is @_responses

casper.on 'resource.received', (resource) -> 
  requests.resolve resource

casper.on 'resource.requested', (resource) ->
  requests.request resource 

casper.on 'requests.done', () ->
  this.echo do this.getHTML

  do this.exit

request = system.args[4].split('=').pop()

casper.start request

do casper.run

casper.then () ->
  this.wait MAX_TIMEOUT

casper.then () ->
  do this.exit