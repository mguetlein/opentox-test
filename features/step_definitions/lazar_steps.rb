When /^I create a lazar model for (.*)$/ do |feature_uri|
	training_uri = @uri
	#puts `curl #{training_uri}`
  resource = RestClient::Resource.new(File.join(@@config[:services]["opentox-algorithm"], "lazar"), :user => @@users[:users].keys[0], :password => @@users[:users].values[0])	
	@uri = resource.post :dataset_uri => training_uri, :feature_uri => feature_uri, :feature_generation_uri => File.join(@@config[:services]["opentox-algorithm"], "fminer")
	@task = OpenTox::Task.find(@uri)
	@resources << @uri
	#puts @uri.to_yaml
end

Then /^the model should predict (.*) for (.*)$/ do |activity,smiles|
	compound_uri = OpenTox::Compound.new(:smiles => smiles).uri
	#puts @uri
	#puts compound_uri
  resource = RestClient::Resource.new(@uri, :user => @@users[:users].keys[0], :password => @@users[:users].values[0])	
	prediction = resource.post :compound_uri => compound_uri, :accept => "application/x-yaml"
	model = Redland::Model.new Redland::MemoryStore.new
	parser = Redland::Parser.new
	parser.parse_string_into_model(model,prediction,'/')

	#puts prediction
	model.subjects(RDF['type'], OT['FeatureValue']).each do |v|
		feature = model.object(v,OT['feature'])
		feature_name = model.object(feature,DC['title']).to_s
		prediction = model.object(v,OT['value']).to_s if feature_name.match(/classification/)
	end
	#puts values.to_yaml
	assert_equal activity.to_s, prediction
end

