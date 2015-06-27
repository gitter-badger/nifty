_ = require 'lodash'
{By} = require 'selenium-webdriver'
chrome = require 'selenium-webdriver/chrome'
chromeDriverPath = require('chromedriver').path
CommandQueue = require './command_queue'
path = require 'path'
url = require 'url'
cssToXpath = require 'css-to-xpath'
dsl = require('xpath-builder').dsl()

chrome.setDefaultService new chrome.ServiceBuilder(chromeDriverPath).build()


class Browser

  constructor: (host) ->
    # Object all commands are called on
    @_context = _.extend {}, Browser.commandMethods,
      browser: this
      driver: new chrome.Driver()
      error: null
      host: Browser.parseHost host

    # Copy command queue commands to this instance
    _.extend this, new CommandQueue @_context


  # These command methods are injected into @_context and are available in commands under `this`
  @commandMethods:

    # Returns a selenium promise for the element of the passed selector
    findElement: (selector) ->
      selector = switch typeof selector
        when 'string' then element: selector
        when 'object' then selector
        else throw "findElement called with #{typeof selector}"

      xpath = cssToXpath.parse(selector.element)
      xpath = xpath.where dsl.contains selector.withText if selector.withText
      @driver.findElement By.xpath xpath.toString()


  @parseHost = (host) ->
    host = url.parse host if typeof host is 'string'

    # Default to the http protocol if not provided
    _.defaults host, protocol: 'http:'


module.exports = Browser
