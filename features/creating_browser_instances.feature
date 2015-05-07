Feature: Creating browser instances

  As a developer creating a browser instance
  I want to be able to provide the host to point to as a url object or a string
  So that I can use Sanelenium with the standard node conventions


  Scenario: providing a string
    Given I create a Sanelenium instance by running "new Browser 'http://example.com:5000'"
    Then I have a browser instance pointing to "http://example.com:5000"


  Scenario Outline: providing a url object
    Given I create a Sanelenium instance by running "new Browser <CONSTRUCTOR ARGUMENTS>"
    Then I have a browser instance pointing to "<SERVER>"

    Examples:
      | CONSTRUCTOR ARGUMENTS                                   | SERVER                   |
      | host: 'example.com:5001'                                | http://example.com:5001  |
      | hostname: 'example.com'                                 | http://example.com       |
      | hostname: 'example.com', port: 5002                     | http://example.com:5002  |
      | protocol: 'https:', hostname: 'example.com'             | https://example.com      |
      | protocol: 'https:', hostname: 'example.com', port: 2000 | https://example.com:2000 |


  Scenario: creating a non-customized browser instance
    Given I create a Sanelenium instance by running "new Browser"
    Then I have a browser instance with no default host configured
