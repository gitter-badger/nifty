Browser = require '../../src/browser'
runCoffee = require '../support/run_coffee'


module.exports = ->

  @Given /^I create a Sanelenium instance by running "([^"]+)"$/, (coffeeExpression, done) ->
    @browser = runCoffee coffeeExpression, {Browser}
    @cleanupTasks.push @browser.close()
    done()


  @When /^I run "([^"]+)"$/, (coffeeExpression, done) ->
    @done = sinon.spy -> done()
    runCoffee coffeeExpression, {@browser, @done}
