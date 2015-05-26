Feature: Sending keyboard shortcuts

  Background:
    Given I create a Sanelenium instance by running "browser = new Browser 'http://localhost:5000'"


  Scenario:
    Given I am on a page with the HTML "<div></div>"
    When I run "browser.$('body').sendShortcut 'ctrl+v', done"
    Then the parameter "done" is called with no arguments
    And my browser captured the shortcut "ctrl+v"
