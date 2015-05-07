_ = require 'lodash'
Browser = require '../../src/browser'
runCoffee = require '../support/run_coffee'
url = require 'url'


module.exports = ->

  @Given /^I am on a page with the html$/, (html, done) ->
    @testWebServer.respondWith html
    @browser.visit '/', done


  @Given /^I create a Sanelenium instance by running "([^"]+)"$/, (coffeeExpression, done) ->
    @browser = runCoffee coffeeExpression, {Browser}
    @cleanupTasks.push @browser.close()
    done()


  @When /^I run "([^"]+)"$/, (coffeeExpression, done) ->
    @done = sinon.spy -> done()
    runCoffee coffeeExpression, {@browser, @done}


  @Then /^it calls done with (?:no arguments|the arguments `([^`]+)`)?$/, (args, done) ->
    expect(@done).to.have.been.calledOnce
    if args?
      parsedArgs = args.split(',').map JSON.parse
      expect(@done).to.have.been.calledWithExactly parsedArgs...
    done()


  @Then /^it calls done with an error$/, (done) ->
    expect(@done).to.have.been.calledOnce
    expect(@done.firstCall.args[0]).to.be.an.instanceof Error
    done()


  @Then /^my browser makes a request to "([^"]+)"$/, (url, done) ->
    expect(@testWebServer.requestHistory).to.contain url
    done()


  @Then /^my browser makes no requests$/, (done) ->
    expect(@testWebServer.requestHistory).to.be.empty
    done()


  @Then /^the "([^"]+)" tag is clicked$/, (tagName, done) ->
    expect(@testWebServer.getEvents event: 'click', tag: tagName).to.have.length 1
    done()


  @Then /^there are no (click) events$/, (eventType, done) ->
    expect(@testWebServer.getEvents event: eventType).to.be.empty
    done()


  @Then /^I have a browser instance pointing to "([^"]+)"$/, (server, done) ->
    expect(@browser).to.be.an.instanceOf Browser
    host = _.omit @browser.host, 'pathname'
    expect(url.format host).to.equal server
    done()


  @Then /^I have a browser instance with no default host configured$/, (done) ->
    expect(@browser).to.be.an.instanceOf Browser
    expect(url.format @browser.host).to.equal ''
    done()


  @Then /^it calls done with the error "([^"]+)"$/, (error, done) ->
    expect(@done).to.have.been.calledOnce
    expect(@done.firstCall.args[0]).to.be.an.instanceof Error
    expect(@done.firstCall.args[0].toString()).to.contain error
    done()
