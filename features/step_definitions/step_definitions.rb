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
    assert page.has_selector?(:xpath, "//table/tr[td = #{location}]")
  end
end
