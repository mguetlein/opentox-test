When /^I apply fminer$/ do
	@training_uri = RestClient.post @@config[:services]["opentox-dataset"], @params
	@resources << @training_uri
	call = "curl -X PUT -F 'file=@#{@filename};type=text/csv' -F compound_format=#{@params['compound_format']} #{@training_uri + '/import'}"
	`#{call}`
	@uri = RestClient.post File.join(@@config[:services]["opentox-algorithm"], "fminer"), :dataset_uri => @training_uri
end
