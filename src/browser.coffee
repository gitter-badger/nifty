_ = require 'lodash'
chrome = require 'selenium-webdriver/chrome'
chromeDriverPath = require('chromedriver').path
CommandQueue = require './command_queue'
path = require 'path'
url = require 'url'

chrome.setDefaultService new chrome.ServiceBuilder(chromeDriverPath).build()


class Browser

  constructor: (host) ->
    # Object all commands are called on
    @_context =
      browser: this
      driver: new chrome.Driver()
      error: null
      host: parseHost host

    # Copy command queue commands to this instance
    _.extend this, new CommandQueue @_context


  parseHost = (host) ->
    host = url.parse host if typeof host is 'string'

    # Default to the http protocol if not provided
    _.defaults host, protocol: 'http:'


module.exports = Browser
