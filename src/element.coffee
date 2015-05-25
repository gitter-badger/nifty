Asyncify = require './asyncify'
{By, Key} = require 'selenium-webdriver'


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


    sendKeys: (keys) ->
      @element.sendKeys keys


    sendShortcut: (shortcut) ->
      keys = shortcut.split '+'
                     .map getModifier
      @element.sendKeys Key.chord(keys...)


    text: ->
      @element.getText()


    val: ->
      @element.getAttribute 'value'


module.exports = Element
