@rest
Feature: Create a model and predict an unknown compound
	As a toxicologist
	I want to create a lazar model
	In order to predict the toxicity of a compound

	Scenario Outline:
		Given name is <name>
		And compound_format is smiles
		And a file <filename>
		When I create a lazar model
		Then I should receive a valid URI
		And the model should predict <prediction> for <smiles>

	Examples:
		|name                   |filename                   |smiles    |prediction|
		|Hamster Carcinogenicity|hamster_carcinogenicity.csv|c1ccccc1NN|true      |
