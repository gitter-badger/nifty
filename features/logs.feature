Feature: Getting browser logs

  Background:
    Given I create a Sanelenium instance by running "new Browser 'http://localhost:5000'"


  Scenario: Getting console.log output
    When the webpage I am on runs `console.log('my message')`
    And I run "browser.getLogs done"
    Then the parameter "done" is called with the 2nd parameter matching the orderly schema
      """
      array {
        object {
          string type["log"];
          string message["my message"];
          string url["http://localhost:5000/"];
          number line;
          number column;
          number timestamp;
        }
      }
      """


  Scenario: Getting console.warn output
    When the webpage I am on runs `console.warn('my warning')`
    And I run "browser.getLogs done"
    Then the parameter "done" is called with the 2nd parameter matching the orderly schema
      """
      array {
        object {
          string type["warn"];
          string message["my warning"];
          string url["http://localhost:5000/"];
          number line;
          number column;
          number timestamp;
        }
      }
      """


  Scenario: Getting console.error output
    When the webpage I am on runs `console.error('my error')`
    And I run "browser.getLogs done"
    Then the parameter "done" is called with the 2nd parameter matching the orderly schema
      """
      array {
        object {
          string type["error"];
          string message["my error"];
          string url["http://localhost:5000/"];
          number line;
          number column;
          number timestamp;
        }
      }
      """


  Scenario: Getting multiple logs
    When the webpage I am on runs
      | console.log('my message')       |
      | console.log('my other message') |
    And I run "browser.getLogs done"
    Then the parameter "done" is called with the 2nd parameter matching the orderly schema
      """
      array {
        object {
          string type["log"];
          string message["my message"];
          string url["http://localhost:5000/"];
          number line;
          number column;
          number timestamp;
        };
        object {
          string type["log"];
          string message["my other message"];
          string url["http://localhost:5000/"];
          number line;
          number column;
          number timestamp;
        }
      }
      """
