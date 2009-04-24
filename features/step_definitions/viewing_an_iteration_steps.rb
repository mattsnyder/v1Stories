Given /^an iteration with Number "([^\"]*)"$/ do |iteration_number|
  @story_data = {}
  @story_data[:id] = iteration_number
  @story_data[:stories] = []
  VersionOne.stub!(:get_stories_by_iteration).and_return @story_data
end

Given /^a story titled "([^\"]*)" is in the iteration$/ do |story_title|
  story_data = {:title => story_title}
  @story_data[:stories].push story_data
end



#https://www10.v1host.com/expectmore/rest-1.v1/Data/Story?where=Timebox.Name=%27Iteration%2012%27
