When /^I create a lazar model for (.*)$/ do |feature_uri|
	training_uri = @uri
	@uri = RestClient.post File.join(@@config[:services]["opentox-algorithm"], "lazar"), :dataset_uri => training_uri, :feature_uri => feature_uri, :feature_generation_uri => File.join(@@config[:services]["opentox-algorithm"], "fminer")
	@resources << @uri
	#puts @uri.to_yaml
end

Then /^the model should predict (.*) for (.*)$/ do |activity,smiles|
	compound_uri = OpenTox::Compound.new(:smiles => smiles).uri
	#puts @uri
	#puts compound_uri
	prediction = RestClient.post @uri, :compound_uri => compound_uri, :type => "yaml"
	puts prediction
	#assert_equal activity.to_s, YAML.load(prediction)[:values]['classification'].to_s
end

