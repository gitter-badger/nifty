Nifty = require '../..'
runCoffee = require '../support/run_coffee'


module.exports = ->

  @Given /^I create a Nifty browser instance by running "niftyBrowser = ([^"]+)"$/, (coffeeExpression, done) ->
    @browser = runCoffee coffeeExpression, {Nifty}
    @cleanupTasks.push (done) => @browser.close().finally done
    done()


  @When /^I run "([^"]+)"$/, (coffeeExpression, done) ->
    @spies.done = sinon.spy -> done()

    runCoffee coffeeExpression, {
      @browser
      done: @spies.done
      spy: @spies.spy
    }


  @When /^I run$/, (coffeeExpression, done) ->
    @spies.done = sinon.spy -> done()

    runCoffee coffeeExpression, {
      @browser
      done: @spies.done
      spy: @spies.spy
    }
