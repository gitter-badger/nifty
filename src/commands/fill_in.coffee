Nifty = require '../..'
nodeify = require 'nodeify'


module.exports = new Nifty.Command 'fillIn', (selector, opts, done) ->
  text = opts.with

  promise = @findElement(selector).sendKeys text
  nodeify promise, done
