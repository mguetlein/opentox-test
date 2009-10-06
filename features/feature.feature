@rest
Feature: Create feature URI

	Scenario Outline: Create URIs
		Given name is <name>
		And <property> is <value>
		When I post the parameters to the feature webservice
		Then I should receive a valid URI
		And the URI should contain <result>

	Examples:
		|name                  |property      |value |result|
		|Rodent carcinogenicity|classification|active|Rodent carcinogenicity/classification/active|
