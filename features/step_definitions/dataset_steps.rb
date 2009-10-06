Given /^a file (.*)$/ do |filename|
	@filename = File.join(File.dirname(__FILE__),'..','data', filename)
end

When /^I put the file to the dataset URI$/ do
	call = "curl -X PUT -F 'file=@#{@filename};type=text/csv' -F compound_format=#{@params['compound_format']} #{@uri + '/import'}"
	@uri = `#{call}`
end

Then /^the URI should return a YAML representation$/ do
	valid_yaml = false
	begin
		@yaml_string = RestClient.get(@uri)
		yaml = YAML.load(@yaml_string)
		valid_yaml = true
	rescue
	end
	assert valid_yaml, true
	#puts @yaml_string
end

When /^I put YAML data to the dataset URI$/ do
	 yaml = File.read(@filename)
	 RestClient.put @uri, :features => yaml
end

