Nifty = require '../..'
runCoffee = require '../support/run_coffee'


module.exports = ->

  @Given /^I create a Nifty browser instance by running "niftyBrowser = ([^"]+)"$/, (coffeeExpression, done) ->
    @niftyBrowser = runCoffee coffeeExpression, {Nifty}
    @cleanupTasks.push (done) => @niftyBrowser.close().finally done
    done()


  @When /^I run$/, (coffeeExpression, done) ->
    @spies.done = sinon.spy -> done()

    runCoffee coffeeExpression, {
      @niftyBrowser
      done: @spies.done
      spy: @spies.spy
    }
