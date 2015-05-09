_ = require 'lodash'
Asyncify = require './asyncify'
chrome = require 'selenium-webdriver/chrome'
chromeDriverPath = require('chromedriver').path
Element = require './element'
url = require 'url'
webdriver = require 'selenium-webdriver'
chrome.setDefaultService new chrome.ServiceBuilder(chromeDriverPath).build()


class Browser extends Asyncify


  mapLog = (log) ->
    {message, level} = log
    type = switch level.name
      when 'INFO' then 'log'
      when 'WARNING' then 'warn'
      when 'SEVERE' then 'error'
    {type, message}


  constructor: (host) ->
    @setHost host
    super
    process.on 'exit', @close

    @driver = new chrome.Driver
      loggingPrefs:
        browser: 'ALL'


  getLogs: (done) ->
    logs = new webdriver.WebDriver.Logs(@driver).get 'browser'
    logs.then (logs) -> done null, logs.map mapLog
    logs.thenCatch (err) -> done err


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
