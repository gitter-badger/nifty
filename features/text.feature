Feature: Reading the text of DOM elements

  Background:
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"


  Scenario: Reading text of an element
    Given I am on a page with the html
      """
      <div>This is <strong>the</strong> text</div>
      """
    When I run "browser.$('div').text done"
    Then it calls done with the arguments
      """
      null,
      "This is the text"
      """
