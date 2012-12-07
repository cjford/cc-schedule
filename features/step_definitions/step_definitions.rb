Given /the following lines exist:/ do |table|
  table.hashes.each do |line|
	l = Line.new(:id => line['id'], :name => line['name'])
	l.save
  end
end

Given /the following locations exist:/ do |table|
  table.hashes.each do |location|
	l = Location.new(:id => location['id'], :name => location['name'])
	l.save
  end
end

Given /the following stops exist:/ do |table|
  table.hashes.each do |stop|
  s = Stop.new(:line_id => stop['line_id'], :location_id => stop['location_id'], 
               :hour => stop['hour'], :minute => stop['minute'], 
               :monday => stop['monday'], :tuesday => stop['tuesday'], 
               :wednesday => stop['wednesday'], :thursday => stop['thursday'], 
               :friday => stop['friday'], :saturday => stop['saturday'], :sunday => stop['sunday'])
  s.save
  end
end

Given /^today is (\S*)$/ do |day|
  case day.downcase
  when "sunday"
    class Time
      def sunday? ; return true end 
      def monday? ; return false end 
      def tuesday? ; return false end 
      def wednesday? ; return false end 
      def thursday? ; return false end 
      def friday? ; return false end 
      def saturday? ; return false end 
    end
  when "monday"
    class Time
      def sunday? ; return false end 
      def monday? ; return true end 
      def tuesday? ; return false end 
      def wednesday? ; return false end 
      def thursday? ; return false end 
      def friday? ; return false end 
      def saturday? ; return false end 
    end
  when "tuesday"
    class Time
      def sunday? ; return false end 
      def monday? ; return false end 
      def tuesday? ; return true end 
      def wednesday? ; return false end 
      def thursday? ; return false end 
      def friday? ; return false end 
      def saturday? ; return false end 
    end
  when "wednesday"
    class Time
      def sunday? ; return false end 
      def monday? ; return false end 
      def tuesday? ; return false end 
      def wednesday? ; return true end 
      def thursday? ; return false end 
      def friday? ; return false end 
      def saturday? ; return false end 
    end
  when "thursday"
    class Time
      def sunday? ; return false end 
      def monday? ; return false end 
      def tuesday? ; return false end 
      def wednesday? ; return false end 
      def thursday? ; return true end 
      def friday? ; return false end 
      def saturday? ; return false end 
    end
  when "friday"
    class Time
      def sunday? ; return false end 
      def monday? ; return false end 
      def tuesday? ; return false end 
      def wednesday? ; return false end 
      def thursday? ; return false end 
      def friday? ; return true end 
      def saturday? ; return false end 
    end
  when "saturday"
    class Time
      def sunday? ; return false end 
      def monday? ; return false end 
      def tuesday? ; return false end 
      def wednesday? ; return false end 
      def thursday? ; return false end 
      def friday? ; return false end 
      def saturday? ; return true end 
    end
  end
end

Given /^I am on (.+)$/ do |page_name|
	visit path_to(page_name)
end

When /^I click "([^"]*)"$/ do |item|
	click_on(item)
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |option, select|
  page.select(option, :from => select)
  sleep(1)
  # Sleep to let ajax calls return. Capybara devs suggest looking for a change in DOM to
  # tell when this happens, but given this step is used in multple scenarios which 
  # expect different things from the DOM, this is not practical.
end

When /^I check "([^"]*)"$/ do |field|
  check(field)
end

When /^I uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

Then /^I should be on (.+)$/ do |page_name|
	current_path = URI.parse(current_url).path
	if current_path.respond_to? :should
		current_path.should == path_to(page_name)
	else
		assert_equal path_to(page_name), current_path
	end
end

Then /^I should\s*(\S+)*\s*see a table entry\s*(?:for "([^"]*)")?$/ do |negative, entry|
  if negative.nil?
    assert page.has_xpath?(".//table/tbody/tr/td/a", :text => "#{entry}", :visible => true)
  else
    assert page.has_no_xpath?(".//table/tbody/tr/td/a", :text => "#{entry}", :visible => true)
  end
end
