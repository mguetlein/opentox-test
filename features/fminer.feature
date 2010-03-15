@rest
Feature: Fminer

	Scenario Outline: Create fminer features
		Given Content-Type is application/x-yaml
		And Accept-Type is application/x-yaml
		And I post <data> to the dataset webservice
		And the task is completed
		And I apply fminer for <feature>
		When the task is completed
		Then I should receive a valid URI

	Examples:
		|feature                   |data                   |
		|http://www.epa.gov/NCCT/dsstox/CentralFieldDef.html#ActivityOutcome_CPDBAS_Hamster|file: hamster_carcinogenicity.yaml|
 # this is too big for sqlite

