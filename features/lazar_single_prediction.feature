@rest
Feature: Create a model and predict an unknown compound
	As a toxicologist
	I want to create a lazar model
	In order to predict the toxicity of a compound

	Scenario Outline:
		Given Content-Type is application/rdf+xml
		And I post <data> to the dataset webservice
		And I create a lazar model for <feature>
		When the task is completed
		Then I should receive a valid URI
		And the model should predict <prediction> for <smiles>

	Examples:
		|feature                   |data                   |smiles    |prediction|
		|http://www.epa.gov/NCCT/dsstox/CentralFieldDef.html#ActivityOutcome_CPDBAS_Hamster|file: hamster_carcinogenicity.owl|c1ccccc1NN|true      |

