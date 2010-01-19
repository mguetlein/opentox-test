When /^I apply fminer for (.*)$/ do |feature_uri|
	dataset_uri = @uri
	resource = RestClient::Resource.new(File.join(@@config[:services]["opentox-algorithm"], "fminer"), :user => @@users[:users].keys[0], :password => @@users[:users].values[0])
	@uri = resource.post(:dataset_uri => dataset_uri, :feature_uri => feature_uri)
	#puts @uri
	@resources << @uri
end
