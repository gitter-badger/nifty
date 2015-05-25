Feature: Getting a value of input elements

  Background:
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"


  Scenario: Reading the value of <input>
    Given I am on a page with the HTML "<input value='foo bar'>"
    When I run "browser.$('input').val done"
    Then the parameter "done" is called with the arguments `null, "foo bar"`


  Scenario: Reading the value of <textarea>
    Given I am on a page with the HTML "<textarea>fizz buzz</textarea>"
    When I run "browser.$('textarea').val done"
    Then the parameter "done" is called with the arguments `null, "fizz buzz"`
