Nifty = require '../..'
nodeify = require 'nodeify'


module.exports = new Nifty.Command 'getValueOf', (selector, callback, done) ->
  promise = @findElement(selector).getAttribute 'value'
  nodeify promise, (err, text) =>
    return done err if err
    callback.call this, text
    done()
