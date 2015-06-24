Browser = require '../../src/browser'
runCoffee = require '../support/run_coffee'


module.exports = ->

  @Given /^I create a Sanelenium instance by running "browser = ([^"]+)"$/, (coffeeExpression, done) ->
    @browser = runCoffee coffeeExpression, {Browser}
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
