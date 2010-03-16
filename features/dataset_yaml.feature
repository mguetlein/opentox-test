@rest
Feature: Dataset

	Scenario Outline: Create a dataset
		Given Content-Type is application/yaml
		And Accept-Type is application/x-yaml
		When I post <data> to the dataset webservice
		#When the task is completed
		Then I should receive a valid URI
		And the URI response should be <data>

	Examples:
		|data|
		|file: hamster_carcinogenicity.yaml|
		|file: hamster_carcinogenicity_fminer_features.yaml|
