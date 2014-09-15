do require('chai').should

filter = require "#{process.cwd()}/src/helpers/htmlFilter"

describe 'helpers/htmlFilter', () ->
  fixutre = null

  beforeEach () ->
    fixutre = '<div><script></script><a class="tag"></a></div>'

  it 'should filter a single selector.', () ->
    result = filter fixutre, '.tag'

    result.should.equal '<div><script></script></div>'

  it 'should filter multiple selectors.', () ->
    result = filter fixutre, ['script', '.tag']

    result.should.equal '<div></div>'