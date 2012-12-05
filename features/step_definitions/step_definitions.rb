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

Given /^I am on (.+)$/ do |page_name|
	visit path_to(page_name)
end

When /^I click "([^"]*)"$/ do |link|
	click_link(link)
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |option, select|
  page.select(option, :from => select)
end

Then /^I should be on (.+)$/ do |page_name|
	current_path = URI.parse(current_url).path
	if current_path.respond_to? :should
		current_path.should == path_to(page_name)
	else
		assert_equal path_to(page_name), current_path
	end
end

Then /^I should see a table of times and lines\s*(?:for "([^"]*)")?$/ do |location|
  assert page.has_table?('upcoming_stops')
  assert page.has_selector?(:xpath, "//tr[th = 'Time' and th = 'Location']")
  if !location.nil?
    assert page.has_xpath?("//table/tbody/tr/td/a[contains(string(), #{location})]")
  end
end
