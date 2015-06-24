{By} = require 'selenium-webdriver'
Command = require '../command'
nodeify = require 'nodeify'


module.exports = new Command 'getText', (selector, callback, done) ->
  promise = @driver.findElement By.css selector
                   .getText()

  nodeify promise, (err, text) =>
    return done err if err
    callback.call this, text
    done()
