Given /^I am on (.+)$/ do |page_name|
	visit path_to(page_name)
end

When /^I click "([^"]*)"$/ do |button|
	click_button(button)
end

When /^I change the location$/ do
end

Then /^I should be on (.+)$/ do |page_name|
	current_path = URI.parse(current_url).path
	if current_path.respond_to? :should
		current_path.should == path_to(page_name)
	else
		assert_equal path_to(page_name), current_path
	end
end


Then /^I should see a (different)?\s*list of times and lines$/ do |different|
end


