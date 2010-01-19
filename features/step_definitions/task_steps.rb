When /^I create a task$/ do
	@uri = RestClient.post @@config[:services]["opentox-task"], nil
	@resources << @uri
end

When /^I finish the task for (.*)$/ do |resource|
	RestClient.put File.join(@uri,"completed"), :resource => resource
end


Then /^the status should be "([^\"]*)"$/ do |status|
	return_status = RestClient.get File.join(@uri,"status")
	assert_equal status, return_status
end

Then /^the resource should be (.*)$/ do |uri|
	resource = RestClient.get File.join(@uri,"resource")
	assert_equal uri, resource
end

