module NavigationHelpers
	def path_to(page_name)
		case page_name
			when /^the home page$/
				"/"
			when /^the location page\s*(?:for "(.+)")?$/
				"/locations/#{$1}"
			when /^the line page\s*(?:for "(.+)")?$/
				"/lines/#{$1}"
		end
	end
end

World(NavigationHelpers)
