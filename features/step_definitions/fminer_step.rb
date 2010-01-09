When /^I apply fminer for (.*)$/ do |feature_uri|
	dataset_uri = @uri
	@uri = RestClient.post File.join(@@config[:services]["opentox-algorithm"], "fminer"), :dataset_uri => dataset_uri, :feature_uri => feature_uri
	@task = OpenTox::Task.find(@uri)
	@resources << @uri
	#puts @uri
end
