@rest @task
Feature: Create and complete a Task

	Scenario Outline: Create and complete a task
		Given I create a task for a <resource>
		When I finish the task 
		Then the status should be "completed"

	Examples:
		|resource|
		|http://my_test_uri|

