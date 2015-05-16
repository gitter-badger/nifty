Feature: Sending keypresses to a webpage

  Background:
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"


  Scenario: Sending keypresses to a textarea
    Given I am on a page with the HTML "<textarea></textarea>"
    When I run "browser.$('textarea').sendKeys 'hello browser', done"
    Then <textarea> has the value "hello browser"
    And the parameter "done" is called with no arguments
