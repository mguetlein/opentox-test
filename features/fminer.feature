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
		|http://ambit.uni-plovdiv.bg:8080/ambit2/feature/12156                             |file: hamster_carcinogenicity_ambit.owl|
 # this is too big for sqlite
	#|http://www.epa.gov/NCCT/dsstox/CentralFieldDef.html#ActivityOutcome_CPDBAS_Hamster|file: hamster_carcinogenicity.owl|

