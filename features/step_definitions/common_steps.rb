Given /^Content-Type is (.*)/ do |content_type|
	@content_type = content_type
end

Given /^Accept-Type is (.*)/ do |accept_type|
	@accept_type = accept_type
end

When /^I post (.*) to the (.*) webservice$/ do |data,component|
	#puts @@config[:services].to_yaml
	#puts @@config[:services]["opentox-#{component}"]
	case data
	when /^file:/
		data = File.read(File.join(File.dirname(File.expand_path(__FILE__)),"../data",data.sub(/file:\s+/,'')))
		@data = data
	end
	uri = RestClient::Resource.new(@@config[:services]["opentox-#{component}"], :user => @@users[:users].keys[0], :password => @@users[:users].values[0]).post data, :content_type => @content_type
	if uri.match(/task/)
		@task = OpenTox::Task.new uri.chomp.to_s
		@resources << uri.chomp.to_s
	else
		@uri = uri.chomp.to_s
		@resources << @uri unless /compound|feature/ =~ component
	end
	#puts @uri
end

Given /^The dataset uri is (.*)$/ do |uri|
	@uri = uri
	# do not delete this !!
end

When /^the task is completed$/ do
	@task.wait_for_completion
	@uri = @task.resource.chomp
	#puts @uri
	@resources << @uri
end

Then /^I should receive a valid URI$/ do
	#puts @uri
	@response = RestClient.get @uri, :accept => @accept_type
	#puts @response.to_yaml
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
	#puts data
	#puts @response
	assert data == @response, true
end

Then /^I should receive valid DATA$/ do
	#puts @uri
	@response = RestClient.get @uri, :accept => @content_type
	#puts @response.to_yaml
end

Then /^the DATA Content-Type should be (.+)$/ do |content_type|
  case @content_type  
  when "image/gif" 
    response_type = @data.to_s.slice(0,3)
    case_type = "GIF"
  end
  assert case_type = response_type, true
end

