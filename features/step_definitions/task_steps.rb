When /^I create a task for a (.*)$/ do |resource_uri|
	@uri = RestClient.post @@config[:services]["opentox-task"], :resource_uri => resource_uri
	@resources << @uri
end

When /^I finish the task$/ do
	RestClient.put File.join(@uri,"completed"), nil
end


Then /^the status should be "([^\"]*)"$/ do |status|
	return_status = RestClient.get File.join(@uri,"status")
	assert_equal status, return_status
end

Then /^the resource should be (.*)$/ do |uri|
	resource = RestClient.get File.join(@uri,"resource")
	assert_equal uri, resource
end

