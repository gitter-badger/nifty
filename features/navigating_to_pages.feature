Feature: Navigating to Pages


  Background:
    Given I create a Sanelenium instance by running "browser = new Browser 'http://localhost:5000'"


  Scenario: Handling illegal arguments
    When I run "browser.visit [], done"
    Then my browser makes no requests
    And the parameter "done" is called with the error "Cannot visit []"
