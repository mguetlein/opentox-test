Given /^(.*) is (.*)$/ do |name,value|
	@params = {} unless @params
	@params[name] = value
end

When /^I post the parameters to the (.*) webservice$/ do |component|
	@uri = RestClient.post @@config[:services]["opentox-#{component}"], @params
	@resources << @uri unless /compound|feature/ =~ component
end

Then /^I should receive a valid URI$/ do
	@response = RestClient.get @uri
end

Then /^the URI should contain (.+)$/ do |result|
	#puts @uri
	regexp = /#{Regexp.escape(URI.encode(result))}/
	assert regexp =~ @uri, true
end

Then /^the URI response should be (\S+)$/ do |result|
	assert result == @response, true
end

