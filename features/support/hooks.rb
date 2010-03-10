Before do
	@resources = []
end

After do |scenario|
=begin
	@resources.uniq!
	@resources.each do |resource| 
		begin
		  RestClient::Resource.new(resource, :user => @@users[:users].keys[0], :password => @@users[:users].values[0]).delete 
		rescue
			puts "Cannot delete " + resource
		end
	end
=end
end
