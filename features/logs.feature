Feature: Getting browser logs

  Background:
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"


  Scenario: Getting console.log output
    When the webpage I am on logs a message: "my message"
    And I run "browser.getLogs done"
    Then it calls done with the arguments
      """
      null,
      [{
        type: 'log',
        message: 'http://localhost:5000/ 1:17 my message',
      }]
      """


  Scenario: Getting console.warn output
    When the webpage I am on logs a warning: "my warning"
    And I run "browser.getLogs done"
    Then it calls done with the arguments
      """
      null,
      [{
        type: 'warn',
        message: 'http://localhost:5000/ 1:17 my warning',
      }]
      """


  Scenario: Getting console.error output
    When the webpage I am on logs an error: "my error"
    And I run "browser.getLogs done"
    Then it calls done with the arguments
      """
      null,
      [{
        type: 'error',
        message: 'http://localhost:5000/ 1:17 my error',
      }]
      """
