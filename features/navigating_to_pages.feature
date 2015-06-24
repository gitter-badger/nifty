Feature: Navigating to Pages


  Background:
    Given I create a Nifty browser instance by running "niftyBrowser = new Nifty.Browser 'http://localhost:5000'"


  Scenario: Handling illegal arguments
    When I run
      """
      niftyBrowser.visit []
                  .finally done
      """
    Then my browser makes no requests
    And the parameter "done" is called with the error "Cannot visit []"
