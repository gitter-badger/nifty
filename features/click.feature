Feature: Clicking on DOM elements

  Background:
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"


  Scenario: Clicking on existing elements
    Given I am on a page with the html
      """
      <button>click me</button>
      """
    When I run "browser.$('button').click done"
    Then the "button" tag is clicked
    And it calls done without error


  Scenario: Clicking on non-existent elements
    Given I am on a page with the html
      """
      <div>click me</div>
      """
    When I run "browser.$('span').click done"
    Then there are no click events
    And it calls done with an error
