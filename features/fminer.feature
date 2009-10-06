@rest
Feature: Fminer

	Scenario Outline: Add data to a dataset
		Given name is <name>
		And compound_format is smiles
		And a file <filename>
		When I apply fminer 
		Then I should receive a valid URI
		And the URI should return a YAML representation

	Examples:
		|name                   |filename                   |
		|Hamster Carcinogenicity|hamster_carcinogenicity.csv|
	#|Salmonella mutagenicity|kazius.csv|

