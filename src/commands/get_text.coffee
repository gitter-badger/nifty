Nifty = require '../..'
nodeify = require 'nodeify'


module.exports = new Nifty.Command 'getText', (selector, callback, done) ->
  promise = @findElement(selector).getText()
  nodeify promise, (err, text) =>
    return done err if err
    callback.call this, text
    done()
