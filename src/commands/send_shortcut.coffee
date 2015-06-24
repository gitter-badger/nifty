{By, Key} = require 'selenium-webdriver'
Command = require '../command'
nodeify = require 'nodeify'


getModifier = (keyName) ->
    {ALT, BACK_SPACE, COMMAND, CONTROL, SHIFT} = Key
    switch keyName.toLowerCase()
      when '⌥', 'alt', 'option' then ALT
      when '⌘', 'cmd', 'command' then (if process.platform is 'darwin' then COMMAND else CONTROL)
      when '⌃', 'ctrl', 'control' then CONTROL
      when '⌫', 'delete', 'backspace' then BACK_SPACE
      when '⇧', 'shift' then SHIFT
      else keyName


module.exports = new Command 'sendShortcut', (selector, shortcut, done) ->
  keys = shortcut.split '+'
                 .map getModifier

  promise = @driver.findElement By.css selector
                   .sendKeys Key.chord keys...

  nodeify promise, done
