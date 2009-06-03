Feature: Validating login credentials
    In order to login
    As a valid user
    I want to validate the user credentials

Scenario: Valid User
    Given I have a valid user with username
    And password
    When I press "Login"
    Then I should see "Projects"
    And I should see "Iterations"
    And I should see "Story"

Scenario: Invalid User
    Given I have a invalid user with username
    And password
    When I press "Login"
    Then I should see "Invalid username/password."
