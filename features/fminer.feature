@rest
Feature: Fminer

	Scenario Outline: Create fminer features
		Given Content-Type is application/rdf+xml
		And I post <data> to the dataset webservice
		And I apply fminer for <feature>
		When the task is completed
		Then I should receive a valid URI

	Examples:
		|feature                   |data                   |
		|http://www.epa.gov/NCCT/dsstox/CentralFieldDef.html#ActivityOutcome_CPDBAS_Hamster|file: hamster_carcinogenicity.owl|
	#|http://dx.doi.org/10.1021/jm040835a|file: data/kazius.rdf|

