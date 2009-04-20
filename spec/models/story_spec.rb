require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story, "find by id" do
  before(:each) do
    @valid_attributes = {
      :number => 5,
      :title => "Print a card",
      :theme => "Version One Extensions",
      :description => "Jason wants to see a story from version one so he can print it.", 
      :owner => 'Cool like cats'
    }
    @valid_attributes = new_story_data("Print a card", "Jason wants to see a story from version one so he can print it.", "Version One Extensions", "Cool man joe")
    VersionOne.stub!(:get_story).and_return @valid_attributes
    @story = Story.find(5)
  end

  it "has a number" do
    @story.number.should == @valid_attributes[:number]
  end
  
  it "has a title" do
    @story.title.should == @valid_attributes[:title]
  end
  
  it "has a theme" do
    @story.theme.should == @valid_attributes[:theme]
  end
  
  it "has a description" do
    @story.description.should == @valid_attributes[:description]
  end
  
  it "has an owner" do
    @story.owner.should == @valid_attributes[:owner]
  end
end

describe Story, "find by iteration" do
  before(:each) do
   @iteration = {}
   @iteration[:stories] = [new_story_data("Story 1"), new_story_data("Story 2"), new_story_data("Story 3")] 
   VersionOne.stub!(:get_stories_by_iteration).and_return @iteration
   @stories = Story.find_by_iteration(1)
  end

  it "has the right number of stories that are returned from VersionOne" do
    @stories.size.should == 3
  end
  
  it "contains the first story" do
    @stories.should have_a_story_with_title("Story 1")
  end
  
  it "contains the second story" do
    @stories.should have_a_story_with_title("Story 2")
  end
  
  it "contains the third story" do
    @stories.should have_a_story_with_title("Story 3")
  end
end
