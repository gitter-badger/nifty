Feature: Creating Sanelenium instances

  As a developer creating a Sanelenium instance
  I want to be able to provide the host to browse using standard Node.js conventions for URLs
  So that I can use Sanelenium like any other Node.js module.


  Scenario: providing the URL as a string
    Given I create a Sanelenium instance by running "browser = new Browser 'http://example.com:5000'"
    Then this instance is pointing to "http://example.com:5000"


  Scenario Outline: providing the URL as an object
    Given I create a Sanelenium instance by running "browser = new Browser <CONSTRUCTOR ARGUMENTS>"
    Then this instance is pointing to "<HOST>"

    Examples:
      | CONSTRUCTOR ARGUMENTS                                   | HOST                     |
      | host: 'example.com:5001'                                | http://example.com:5001  |
      | hostname: 'example.com'                                 | http://example.com       |
      | hostname: 'example.com', port: 5002                     | http://example.com:5002  |
      | protocol: 'https:', hostname: 'example.com'             | https://example.com      |
      | protocol: 'https:', hostname: 'example.com', port: 2000 | https://example.com:2000 |


  Scenario: creating an uncustomized instance
    Given I create a Sanelenium instance by running "browser = new Browser()"
    Then this instance has no default host configured
