When /^I apply fminer for (.*)$/ do |feature_uri|
	dataset_uri = @uri
	resource = RestClient::Resource.new(File.join(@@config[:services]["opentox-algorithm"], "fminer"), :timeout => 60)
	@uri = resource.post :dataset_uri => dataset_uri, :feature_uri => feature_uri
	@task = OpenTox::Task.find(@uri)
	@resources << @uri
	#puts @uri
end
