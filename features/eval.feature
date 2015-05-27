Feature: Evaluating javascript


  Background:
    Given I create a Sanelenium instance by running "browser = new Browser 'http://localhost:5000'"


  Scenario: Executing javascript in the browser
    Given I visit a page
    When I run "browser.eval 'myFn()', done"
    Then the "myFn" javascript function is called in my browser
    Then the parameter "done" is called with no arguments


  Scenario: adding a return statement in eval expressions returns the value
    Given I am on a page with the HTML "<title>my page title</title>"
    When I run "browser.eval 'return document.title', done"
    Then the parameter "done" is called with the arguments `null, "my page title"`
