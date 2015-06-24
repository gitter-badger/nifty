Feature: Sending keyboard shortcuts

  Background:
    Given I create a Nifty browser instance by running "niftyBrowser = new Nifty.Browser 'http://localhost:5000'"


  Scenario:
    Given I am on an empty page
    When I run
      """
      browser.sendShortcut 'body', 'ctrl+v'
             .finally done
      """
    Then my browser receives the shortcut "ctrl+v"
    And the parameter "done" is called with the arguments `null`
