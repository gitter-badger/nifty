Feature:


  Background:
    Given I create a Sanelenium instance by running "browser = new Browser 'http://localhost:5000'"
    Given I am on a page with the HTML
      """
      <div id="hidden" style="display: none">hidden</div>
      <div id="visible" style="display: block">visible</div>
      """


  Scenario:
    When I run "browser.$('#visible').is ':visible', done"
    Then the parameter "done" is called with the arguments `null, true`
    When I run "browser.$('#hidden').is ':visible', done"
    Then the parameter "done" is called with the arguments `null, false`


  Scenario:
    When I run "browser.$('#hidden').is ':hidden', done"
    Then the parameter "done" is called with the arguments `null, true`
    When I run "browser.$('#visible').is ':hidden', done"
    Then the parameter "done" is called with the arguments `null, false`
