Asyncify = require './asyncify'
Element = require './element'
webdriver = require 'selenium-webdriver'


class Browser extends Asyncify

  constructor: ->
    super
    process.on 'exit', @close

    @driver = new webdriver.Builder()
                           .withCapabilities webdriver.Capabilities.chrome()
                           .build()


  $: (selector) =>
    new Element this, selector


  asyncify:

    close: ->
      return if @closed
      @closed = yes
      @driver.quit()


    visit: (url) ->
      @driver.get url


module.exports = Browser
