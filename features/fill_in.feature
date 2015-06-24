Feature: Sending keypresses to a webpage

  Background:
    Given I create a Nifty browser instance by running "niftyBrowser = new Nifty.Browser 'http://localhost:5000'"


  Scenario: Sending keypresses to a textarea
    Given I am on a page with the HTML "<textarea></textarea>"
    When I run
      """
      browser.fillIn 'textarea', with: 'hello browser'
             .finally done
      """
    Then the <textarea> on my page has the value "hello browser"
    And the parameter "done" is called with the arguments `null`


  Scenario: Filling in non-existent elements
    Given I am on an empty page
    When I run
      """
      browser.fillIn 'textarea', spy
             .finally done
      """
    Then "spy" is never called
    And "done" is called with the error "no such element"
