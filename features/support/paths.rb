module NavigationHelpers
	def path_to(page_name)
		case page_name
			when /^the home page$/
				"/"
			when /^the locations page\s*(?:for "(.+)")?$/
        if $1.nil?
          "/locations"
        else
          location_id = Location.find_by_name($1).id
          "/locations/#{location_id}"
        end
			when /^the lines page\s*(?:for "(.+)")?$/
        if $1.nil?
          "/lines"
        else
          line_id = Line.find_by_name($1).id
          "/lines/#{line_id}"
        end
		end
	end
end

World(NavigationHelpers)
