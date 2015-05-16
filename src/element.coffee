Asyncify = require './asyncify'
{By, promise} = require 'selenium-webdriver'

class Element extends Asyncify

  constructor: (@browser, @selector) ->
    super
    @element = @browser.driver
                       .findElement By.css @selector


  asyncify:
    click: ->
      @element.click()


    is: (condition) ->
      switch condition
        when ':visible' then @element.isDisplayed()
        when ':hidden' then promise.when @element.isDisplayed(), (visible) => not visible


    text: ->
      @element.getText()


module.exports = Element
