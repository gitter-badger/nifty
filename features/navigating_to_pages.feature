Feature: Navigating to Pages

  Scenario: Making invalid browser requests
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"
    When I run "browser.visit [], done"
    Then my browser makes no requests
    And it calls done with the error "Cannot visit []"
