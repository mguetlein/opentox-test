@rest
Feature: Create Task

	Scenario Outline: Create a task
		When I create a task for a <resource>
		Then I should receive a valid URI
		And the status should be "started"
		And the resource should be <resource>

	Examples:
		|resource|
		|http://my_test_uri|

