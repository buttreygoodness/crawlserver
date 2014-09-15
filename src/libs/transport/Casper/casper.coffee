Casper = require 'casper'
system = require 'system'

casper = Casper.create
  waitTimeout: 5000

request = system.args[4].split('=').pop()

casper.start request

casper.then () ->
  this.wait 1000, () ->
    this.echo do this.getHTML

casper.then () ->
  do this.exit

do casper.run