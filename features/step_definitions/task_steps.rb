When /^I create a task$/ do
  
	@uri = RestClient::Resource.new(@@config[:services]["opentox-task"], :user => @@users[:users].keys[0], :password => @@users[:users].values[0]).post nil
	@uri.chomp!
	@resources << @uri
end

When /^I finish the task for (.*)$/ do |resource|
	#puts File.join(@uri,"completed")
  RestClient::Resource.new(File.join(@uri,"completed"), :user => @@users[:users].keys[0], :password => @@users[:users].values[0]).put :resource => resource
end


Then /^the status should be "([^\"]*)"$/ do |status|
	#puts File.join(@uri,"status")
	return_status = RestClient.get File.join(@uri,"status")
	assert_equal status, return_status
end

Then /^the resource should be (.*)$/ do |uri|
	resource = RestClient.get File.join(@uri,"resource")
	assert_equal uri, resource
end

