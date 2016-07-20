@skip
Feature: Authentication


  Scenario: Log in
    When I log in

  Scenario: Authentication failed
    When I log in with an invalid account
    Then I cannot log in
