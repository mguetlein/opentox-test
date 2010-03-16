When /^I create a lazar model for (.*)$/ do |feature_uri|
	@feature_uri = feature_uri
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
	prediction = YAML.load(`curl -X POST -d 'compound_uri=#{compound_uri}' -H 'Accept:application/x-yaml' #{@uri}`)
	classification = prediction.data[compound_uri].first.values.first[:classification]
	#puts classification
	assert_equal activity.to_s, classification.to_s
end

Given /^I post the test dataset (.*)$/ do |test_dataset|
	data = File.read(File.join(File.dirname(File.expand_path(__FILE__)),"../data",test_dataset.sub(/file:\s+/,'')))
	@test_uri = RestClient::Resource.new(@@config[:services]["opentox-dataset"], :user => @@users[:users].keys[0], :password => @@users[:users].values[0]).post(data, :content_type => @content_type).to_s.chomp
	@resources << @test_uri
end

Given /^I predict the test dataset$/ do 
	@uri = `curl -X POST -d 'dataset_uri=#{@test_uri}' -H 'Accept:application/x-yaml' #{@uri}`.chomp
	#puts @uri
	@task = OpenTox::Task.find(@uri)
	#puts @task
	@resources << @uri
end

