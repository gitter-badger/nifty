_ = require 'lodash'
chrome = require 'selenium-webdriver/chrome'
chrome.setDefaultService new chrome.ServiceBuilder(chromeDriverPath).build()
chromeDriverPath = require('chromedriver').path
CommandLoader = require './command_loader'
CommandQueue = require './command_queue'
path = require 'path'
url = require 'url'


class Browser

  constructor: (host) ->
    commandLoader = new CommandLoader
    commandLoader.loadDirectory path.join(__dirname, 'commands')

    # Object all commands are called on
    @_context =
      browser: this
      driver: new chrome.Driver()
      error: null
      host: parseHost host

    # Copy command queue commands to this instance
    _.extend this, new CommandQueue
      commands: commandLoader.commands
      context: @_context


  parseHost = (host) ->
    host = url.parse host if typeof host is 'string'

    # Default to the http protocol if not provided
    _.defaults host, protocol: 'http:'


module.exports = Browser
