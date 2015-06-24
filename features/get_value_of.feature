Feature: Getting a value of input elements

  Background:
    Given I create a Nifty browser instance by running "niftyBrowser = new Nifty.Browser 'http://localhost:5000'"


  Scenario: Reading the value of <input>
    Given I am on a page with the HTML "<input value='foo bar'>"
    When I run
      """
      browser.getValueOf 'input', spy
             .finally done
      """
    Then "spy" is called with the arguments `"foo bar"`
    Then the parameter "done" is called with the arguments `null`


  Scenario: Reading the value of <textarea>
    Given I am on a page with the HTML "<textarea>fizz buzz</textarea>"
    When I run
      """
      browser.getValueOf 'textarea', spy
             .finally done
      """
    Then "spy" is called with the arguments `"fizz buzz"`
    Then the parameter "done" is called with the arguments `null`


  Scenario: Getting the value of non-existent elements
    Given I am on an empty page
    When I run
      """
      browser.getValueOf 'textarea', spy
             .finally done
      """
    Then "spy" is never called
    And "done" is called with the error "no such element"
