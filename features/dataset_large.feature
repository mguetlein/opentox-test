@rest
Feature: Dataset

	Scenario Outline: Add data to a dataset
		Given name is <name>
		And compound_format is smiles
		And a file <filename>
		When I post the parameters to the dataset webservice
		And I put the file to the dataset URI
		Then I should receive a valid URI
		And the URI should return a YAML representation

	Examples:
		|name|filename|
		|Salmonella mutagenicity|kazius.csv|
