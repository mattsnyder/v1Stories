Given /^a story with Number "([^\"]*)"$/ do |number|
  @story_data = {}
  @story_data[:number] = number
  VersionOne.stub!(:get_story).and_return @story_data
end

Given /^Title "([^\"]*)"$/ do |title|
  @story_data[:title] = title
end

Given /^Theme "([^\"]*)"$/ do |theme|
  @story_data[:theme] = theme
end

Given /^Description "([^\"]*)"$/ do |description|
  @story_data[:description] = description
end

Given /^Owner "([^\"]*)"$/ do |owner|
  @story_data[:owner] = owner
end

Given /^Title with of "([^\"]*)" X's$/ do |length|
  @story_data[:title] = "X" * length.to_i
end

Then /^I should see "([^\"]*)" X's$/ do |length|
  response.should contain("X"*length.to_i)
end







