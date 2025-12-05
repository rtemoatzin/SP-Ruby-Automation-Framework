Feature: Tasks - Full Create

  @ui
  Scenario: Create a task filling all fields and complete it
    Given I log into SimplePractice
    When I go to the Tasks page
    And I create a fully detailed task
    And I mark the task as Completed
    Then I should see the task in the Completed filter
