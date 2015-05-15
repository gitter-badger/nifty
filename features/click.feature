Feature: Clicking on DOM elements

  Background:
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"


  Scenario: Clicking on existing elements
    Given I am on a page with the HTML "<button>click me</button>"
    When I run "browser.$('button').click done"
    Then the <button> tag is clicked
    And the parameter "done" is called with no arguments


  Scenario: Clicking on non-existent elements
    Given I am on a page with the HTML "<div>click me</div>"
    When I run "browser.$('span').click done"
    Then there are no click events
    And the parameter "done" is called with the error "no such element"
