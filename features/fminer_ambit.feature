@rest
Feature: Fminer

	Scenario Outline: Create fminer features
		Given The dataset uri is <dataset_uri>
		And I apply fminer for <feature>
		When the task is completed
		Then I should receive a valid URI

	Examples:
		|feature                                              |dataset_uri                                      |
		|http://ambit.uni-plovdiv.bg:8080/ambit2/reference/11847|http://ambit.uni-plovdiv.bg:8080/ambit2/dataset/9|
		#|http://ambit.uni-plovdiv.bg:8080/ambit2/feature/12156|http://ambit.uni-plovdiv.bg:8080/ambit2/dataset/9|
	#|http://ambit.uni-plovdiv.bg:8080/ambit2/feature/12100|http://ambit.uni-plovdiv.bg:8080/ambit2/dataset/8|

