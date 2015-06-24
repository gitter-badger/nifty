{By} = require 'selenium-webdriver'
Command = require '../command'
nodeify = require 'nodeify'


module.exports = new Command 'click', (selector, done) ->
  promise = @driver.findElement By.css selector
                   .click()

  nodeify promise, done
