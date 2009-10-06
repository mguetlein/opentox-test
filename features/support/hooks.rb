Before do
	@resources = []
end

After do |scenario|
	@resources.uniq!
	@resources.each do |resource| 
		begin
			RestClient.delete resource 
		rescue
			puts "Cannot delete " + resource
		end
	end
end
