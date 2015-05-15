_ = require 'lodash'
Browser = require '../../src/browser'
url = require 'url'


module.exports = ->

  @Given /^I am on a page with the HTML$/, (html, done) ->
    @testWebServer.respondWith html
    @browser.visit '/', done


  @Given /^I am on a page with the HTML "([^"]+)"$/, (html, done) ->
    @testWebServer.respondWith html
    @browser.visit '/', done



  @Then /^my browser makes a request to "([^"]+)"$/, (url, done) ->
    expect(@testWebServer.requestHistory).to.contain url
    done()


  @Then /^my browser makes no requests$/, (done) ->
    expect(@testWebServer.requestHistory).to.be.empty
    done()


  @Then /^the <([^"]+)> tag is clicked$/, (tagName, done) ->
    expect(@testWebServer.getEvents event: 'click', tag: tagName).to.have.length 1
    done()


  @When /^the webpage I am on logs an? (message|warning|error): "([^"]+)"$/, (type, message, done) ->
    method = switch type
      when 'message' then 'log'
      when 'warning' then 'warn'
      when 'error' then 'error'
    @testWebServer.respondWith "<script>console.#{method}(#{JSON.stringify message});</script>"
    @browser.visit '/', done


  @Then /^there are no (click) events$/, (eventType, done) ->
    expect(@testWebServer.getEvents event: eventType).to.be.empty
    done()


  @Then /^this instance has no default host configured$/, (done) ->
    expect(@browser).to.be.an.instanceOf Browser
    expect(url.format @browser.host).to.equal ''
    done()


  @Then /^this instance is pointing to "([^"]+)"$/, (server, done) ->
    expect(@browser).to.be.an.instanceOf Browser
    host = _.omit @browser.host, 'pathname'
    expect(url.format host).to.equal server
    done()
