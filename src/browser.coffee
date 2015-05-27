_ = require 'lodash'
Asyncify = require './asyncify'
chrome = require 'selenium-webdriver/chrome'
chromeDriverPath = require('chromedriver').path
Element = require './element'
url = require 'url'
webdriver = require 'selenium-webdriver'
chrome.setDefaultService new chrome.ServiceBuilder(chromeDriverPath).build()


class Browser extends Asyncify

  constructor: (host) ->
    @setHost host
    super
    process.on 'exit', @close

    @driver = new chrome.Driver()


  $: (selector) =>
    new Element this, selector


  setHost: (host) ->
    host = url.parse host if typeof host is 'string'

    # Default to the http protocol if not provided
    @host = _.defaults host, protocol: 'http:'


  asyncify:

    close: ->
      return if @closed
      # Remove exit listener to prevent EventEmitter from reporting a memory leak
      process.removeListener 'exit', @close
      @closed = yes
      @driver.quit()


    eval: (javascript) ->
      @driver.executeScript javascript


    visit: (pathname) ->
      try
        @driver.get url.format _.defaults(
          {pathname}        # pathname takes precedence
          @host             # Fill in all other fields from @host
        )
      catch err
        Error "Cannot visit #{JSON.stringify pathname}"


module.exports = Browser
