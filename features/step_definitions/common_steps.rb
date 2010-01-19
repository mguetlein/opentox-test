Given /^Content-Type is (.*)/ do |content_type|
	@content_type = content_type
end

When /^I post (.*) to the (.*) webservice$/ do |data,component|
	#puts @@config[:services]["opentox-#{component}"]
	case data
	when /^file:/
		data = File.read(File.join(File.dirname(File.expand_path(__FILE__)),"../data",data.sub(/file:\s+/,'')))
		@data = data
	end
	@uri = RestClient::Resource.new(@@config[:services]["opentox-#{component}"], :user => @@users[:users].keys[0], :password => @@users[:users].values[0]).post data, :content_type => @content_type
	@resources << @uri unless /compound|feature/ =~ component
end

When /^I get (.*) from the (.*) webservice$/ do |get_request,component|
	@uri = @@config[:services]["opentox-#{component}"] + "test/#{component}/" + get_request
  @response = RestClient.get @uri, :accept => @content_type
end

Then /^I should receive a valid URI$/ do
	#puts @uri
	@response = RestClient.get @uri, :accept => '*/*'
	puts @response.to_yaml
end

Then /^the URI should contain (.+)$/ do |result|
	#puts @uri
	regexp = /#{Regexp.escape(URI.encode(result))}/
	assert regexp =~ @uri, true
end

Then /^the URI response should be (.+)$/ do |data|
	case data
	when /^file:/
		data = @data
	end
	assert data == @response, true
end

Then /^I should receive valid DATA$/ do
	#puts @uri
	@response = RestClient.get @uri, :accept => @content_type
	puts @response.to_yaml
end

Then /^the DATA Content-Type should be (.+)$/ do |content_type|
  case @content_type  
  when "image/gif" 
    response_type = @data.to_s.slice(0,3)
    case_type = "GIF"
  end
  assert case_type = response_type, true
end

