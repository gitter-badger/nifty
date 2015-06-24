_ = require 'lodash'
Browser = require '../../src/browser'
url = require 'url'


module.exports = ->

  @Given /^I am on a page with the HTML$/, (html, done) ->
    @testWebServer.respondWith html
    @browser.visit '/'
            .finally done


  @Given /^I am on a page with the HTML "([^"]+)"$/, (html, done) ->
    @testWebServer.respondWith html
    @browser.visit '/'
            .finally done


  @Given /^I am on an empty page$/, (done) ->
    @testWebServer.respondWith ''
    @browser.visit '/'
            .finally done


  @Then /^the <textarea> on my page has the value "([^"]+)"$/, (expectedValue, done) ->
    @browser.getValueOf 'textarea', (value) -> expect(value).to.equal expectedValue
            .finally done



  @Then /^my browser makes a request to "([^"]+)"$/, (url, done) ->
    expect(@testWebServer.requestHistory).to.contain url
    done()


  @Then /^my browser makes no requests$/, (done) ->
    expect(@testWebServer.requestHistory).to.be.empty
    done()


  @Then /^my browser receives the shortcut "([^"]+)"$/, (shortcut, done) ->
    expect(@testWebServer.getEvents {event: 'keydown', shortcut}).to.have.length 1
    done()


  @Then /^the <([^"]+)> tag is clicked$/, (tagName, done) ->
    expect(@testWebServer.getEvents event: 'click', tag: tagName).to.have.length 1
    done()


  @Then /^there are no (click) events$/, (eventType, done) ->
    expect(@testWebServer.getEvents event: eventType).to.be.empty
    done()


  @Then /^this instance has no default host configured$/, (done) ->
    expect(@browser).to.be.an.instanceOf Browser
    expect(url.format @browser._context.host).to.equal ''
    done()


  @Then /^this instance is pointing to "([^"]+)"$/, (server, done) ->
    expect(@browser).to.be.an.instanceOf Browser
    host = _.omit @browser._context.host, 'pathname'
    expect(url.format host).to.equal server
    done()
