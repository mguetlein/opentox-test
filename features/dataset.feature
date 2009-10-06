@rest
Feature: Dataset

	Scenario Outline: Create dataset
		Given name is <name>
		When I post the parameters to the dataset webservice
		Then I should receive a valid URI
		And the URI should contain <name>

	Examples:
		|name|
		|Test|
		|Rodent Carcinogenicity|


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
		|Hamster Carcinogenicity|hamster_carcinogenicity.csv|

	Scenario Outline: Add YAML data
		Given name is <name>
		Given a file <filename>
		When I post the parameters to the dataset webservice
		And I put YAML data to the dataset URI
		Then I should receive a valid URI
		And the URI should return a YAML representation

	Examples:
		|name|filename|
		|Hamster Carcinogenicity BBRC features|hamster_carcinogenicity_bbrc_features.yaml|
