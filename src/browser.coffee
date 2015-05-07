_ = require 'lodash'
Asyncify = require './asyncify'
Element = require './element'
url = require 'url'
webdriver = require 'selenium-webdriver'


class Browser extends Asyncify

  constructor: (host) ->
    @setHost host
    super
    process.on 'exit', @close

    @driver = new webdriver.Builder()
                           .withCapabilities webdriver.Capabilities.chrome()
                           .build()


  $: (selector) =>
    new Element this, selector


  setHost: (host) ->
    host = url.parse host if typeof host is 'string'

    # Default to the http protocol if not provided
    @host = _.defaults host, protocol: 'http:'


  asyncify:

    close: ->
      return if @closed
      @closed = yes
      @driver.quit()


    visit: (pathname) ->
      try
        @driver.get url.format _.defaults(
          {pathname}        # pathname takes precedence
          @host             # Fill in all other fields from @host
        )
      catch err
        Error "Cannot visit #{JSON.stringify pathname}"


module.exports = Browser
