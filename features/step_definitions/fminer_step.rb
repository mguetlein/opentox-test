When /^I apply fminer for (.*)$/ do |feature_uri|
	dataset_uri = @uri
  resource = RestClient::Resource.new(File.join(@@config[:services]["opentox-algorithm"], "fminer"), :timeout => 60, :user => @@users[:users].keys[0], :password => @@users[:users].values[0])
	@uri = resource.post(:dataset_uri => dataset_uri, :feature_uri => feature_uri).chomp
	@task = OpenTox::Task.find(@uri)
	@resources << @uri
	#puts @uri
end
