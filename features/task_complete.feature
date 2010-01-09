@rest @task
Feature: Create and complete a Task

	Scenario Outline: Create and complete a task
		Given I create a task
		When I finish the task for <resource> 
		Then the status should be "completed"
		And the resource should be <resource>

	Examples:
		|resource|
		|http://my_test_uri|

