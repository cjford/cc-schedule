module NavigationHelpers
	def path_to(page_name)
		case page_name
			when /^the home page$/
				"/"
			when /^the location page (?:for "(.+)"?)$/
				"/locations/#{$1}"
			when /^the line page (?:for "(.+)")?$/
				"/lines/#{$1}"
		end
	end
end
