Asyncify = require './asyncify'
{By} = require 'selenium-webdriver'

class Element extends Asyncify

  constructor: (@browser, @selector) ->
    super
    @element = @browser.driver
                       .findElement By.css @selector


  asyncify:
    click: ->
      @element.click()


    text: ->
      @element.getText()


module.exports = Element
