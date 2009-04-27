Given /^an iteration with Number "([^\"]*)"$/ do |iteration_number|
  @story_data = {}
  @story_data[:id] = iteration_number
  @story_data[:stories] = []
  VersionOne.stub!(:get_stories_by_iteration).and_return @story_data
end

Given /^a story titled "([^\"]*)" is in the iteration$/ do |story_title|
  story_data = new_story_data(story_title)
  @story_data[:stories].push story_data
end


