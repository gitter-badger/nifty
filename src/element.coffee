Asyncify = require './asyncify'
{By, Key, promise} = require 'selenium-webdriver'


wait = (ms) -> ->
  deferred = new promise.Deferred
  setTimeout deferred.fulfill, ms
  deferred


class Element extends Asyncify

  getModifier = (keyName) ->
    {ALT, BACK_SPACE, COMMAND, CONTROL, SHIFT} = Key
    switch keyName.toLowerCase()
      when '⌥', 'alt', 'option' then ALT
      when '⌘', 'cmd', 'command' then (if process.platform is 'darwin' then COMMAND else CONTROL)
      when '⌃', 'ctrl', 'control' then CONTROL
      when '⌫', 'delete', 'backspace' then BACK_SPACE
      when '⇧', 'shift' then SHIFT
      else keyName


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


    sendKeys: (keys) ->
      @element.sendKeys keys


    sendShortcut: (shortcut) ->
      keys = shortcut.split '+'
                     .map getModifier
      @element
        .sendKeys Key.chord(keys...)
        # Selenium continues too soon after sending a shortcut
        # wait 10ms to make sure the shortcut was sent
        .then wait 10


    text: ->
      @element.getText()


    val: ->
      @element.getAttribute 'value'


module.exports = Element
