When /^I create a lazar model$/ do 
	@training_uri = RestClient.post @@config[:services]["opentox-dataset"], @params
	@resources << @training_uri
	call = "curl -X PUT -F 'file=@#{@filename};type=text/csv' -F compound_format=#{@params['compound_format']} #{@training_uri + '/import'}"
	`#{call}`
	@feature_uri = RestClient.post File.join(@@config[:services]["opentox-algorithm"], "fminer"), :dataset_uri => @training_uri
	@resources << @feature_uri
	@uri = RestClient.post File.join(@@config[:services]["opentox-algorithm"], "lazar_classification"), :activity_dataset_uri => @training_uri, :feature_dataset_uri => @feature_uri
	@resources << @uri
end

Then /^the model should predict (.*) for (.*)$/ do |activity,smiles|
	compound_uri = OpenTox::Compound.new(:smiles => smiles).uri
	prediction_uri = RestClient.post @uri, :compound_uri => compound_uri
	prediction = RestClient.get prediction_uri
	assert_equal activity.to_s, YAML.load(prediction)[:values]['classification'].to_s
end

