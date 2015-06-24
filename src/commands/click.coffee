Nifty = require '../..'
nodeify = require 'nodeify'


module.exports = new Nifty.Command 'click', (selector, done) ->
  nodeify @findElement(selector).click(), done
