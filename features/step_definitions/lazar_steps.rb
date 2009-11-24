When /^I create a lazar model for (.*)$/ do |feature_uri|
	training_uri = @uri
	feature_uri = RestClient.post File.join(@@config[:services]["opentox-algorithm"], "fminer"), :dataset_uri => training_uri, :feature_uri => feature_uri
	@resources << feature_uri
	@uri = RestClient.post File.join(@@config[:services]["opentox-model"], "lazar"), :activity_dataset_uri => training_uri, :feature_dataset_uri => feature_uri
	@resources << @uri
end

Then /^the model should predict (.*) for (.*)$/ do |activity,smiles|
	compound_uri = OpenTox::Compound.new(:smiles => smiles).uri
	puts @uri
	prediction = RestClient.post @uri, :compound_uri => compound_uri
	puts prediction
	#prediction = RestClient.get prediction_uri
	#assert_equal activity.to_s, YAML.load(prediction)[:values]['classification'].to_s
end

