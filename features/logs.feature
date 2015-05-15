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
        message: 'my message',
        url: 'http://localhost:5000',
        line: <NUMBER>,
        column: <NUMBER>,
        timestamp: <DATE>
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
    When the web page in my browser runs "console.log('my message')"
    And I run "browser.getLogs done"
    Then it calls done with the arguments
      """
      null,
      [{
        type: 'error',
        message: 'http://localhost:5000/ 1:17 my error',
      }]
      """


  Scenario: Getting multiple logs
    When the web page in my browser runs "console.log('my message')"
      | console.log('my message')       |
      | console.log('my other message') |
    And I run "browser.getLogs done"
    Then it calls done with the arguments
      """
      null,
      [{
        type: 'log',
        message: 'my message',
        url: 'http://localhost:5000',
        line: <NUMBER>,
        column: <NUMBER>,
        timestamp: <DATE>
      },
      {
        type: 'log',
        message: 'my other message',
        url: 'http://localhost:5000',
        line: <NUMBER>,
        column: <NUMBER>,
        timestamp: <DATE>
      }]
      """
