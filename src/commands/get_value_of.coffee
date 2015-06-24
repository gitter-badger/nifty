{By} = require 'selenium-webdriver'
Command = require '../command'
nodeify = require 'nodeify'


module.exports = new Command 'getValueOf', (selector, callback, done) ->
  promise = @driver.findElement By.css selector
                   .getAttribute 'value'

  nodeify promise, (err, text) =>
    return done err if err
    callback.call this, text
    done()
