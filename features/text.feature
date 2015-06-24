Feature: Reading the text of DOM elements


  Background:
    Given I create a Nifty browser instance by running "niftyBrowser = new Nifty.Browser 'http://localhost:5000'"


  Scenario: Reading text of an element
    Given I am on a page with the HTML
      """
      <div>This is <strong>the</strong> text</div>
      """
      When I run
        """
        niftyBrowser.getText 'div', spy
                    .finally done
        """
    Then "spy" is called with the arguments `"This is the text"`
    And "done" is called with the arguments `null`
