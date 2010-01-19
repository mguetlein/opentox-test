@rest
Feature: Create Task

	Scenario Outline: Create a task
		When I create a task
		Then I should receive a valid URI
		And the status should be "created"

	Examples:
		|resource|
		|http://my_test_uri|

