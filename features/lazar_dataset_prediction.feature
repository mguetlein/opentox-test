@rest
Feature: Create a model and predict a dataset
	As a toxicologist
	I want to create a lazar model
	In order to predict the toxicity of a compound

	Scenario Outline:
		Given Content-Type is application/x-yaml
		And Accept-Type is application/x-yaml
		And I post <training_data> to the dataset webservice
		And I create a lazar model for <feature>
		And the task is completed
		And I post the test dataset <prediction_data>
		And I predict the test dataset
		When the task is completed
		Then I should receive a valid URI

	Examples:
		|feature                                              											|training_data                     |prediction_data|
		|http://localhost/toxmodel/feature#Hamster%20Carcinogenicity%20(DSSTOX/CPDB)|file: hamster_carcinogenicity.yaml|file: test.yaml|
	#|http://www.epa.gov/NCCT/dsstox/CentralFieldDef.html#ActivityOutcome_CPDBAS_Hamster|file: hamster_carcinogenicity.yaml|c1ccccc1NN|true      |
	#|http://ambit.uni-plovdiv.bg:8080/ambit2/feature/12156|file: hamster_carcinogenicity_ambit.owl|c1ccccc1NN|true      |

