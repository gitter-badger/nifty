{By} = require 'selenium-webdriver'
Command = require '../command'
nodeify = require 'nodeify'


module.exports = new Command 'fillIn', (selector, opts, done) ->
  text = opts.with

  promise = @driver.findElement By.css selector
                   .sendKeys text

  nodeify promise, done
