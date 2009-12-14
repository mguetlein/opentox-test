@rest
Feature: Fminer

	Scenario Outline: Create fminer features
		Given Content-Type is application/rdf+xml
		And I post <data> to the dataset webservice
		When I apply fminer for <feature>
		Then I should receive a valid URI

	Examples:
		|feature                   |data                   |
		|http://www.epa.gov/NCCT/dsstox/CentralFieldDef.html#ActivityOutcome_CPDBAS_Hamster|file: hamster_carcinogenicity.rdf|
	#|http://dx.doi.org/10.1021/jm040835a|file: data/kazius.rdf|

