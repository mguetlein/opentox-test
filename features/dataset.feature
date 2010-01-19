@rest
Feature: Dataset

	Scenario Outline: Create a dataset
		Given Content-Type is application/rdf+xml
		When I post <data> to the dataset webservice
		Then I should receive a valid URI

	Examples:
		|data|
		|file: hamster_carcinogenicity.owl|
