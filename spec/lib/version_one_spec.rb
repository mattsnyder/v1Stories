require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VersionOne, "find story by story number" do
  before(:each) do
    # def initialize(title=nil, description=nil, estimate=nil, theme=nil, iteration=nil, owner=nil, number=nil)
    @story_data = Story.new("Add support for printing cards", nil, "X-Large", nil, nil, "Jason Phillips", nil)
    VersionOne.stub!(:request_xml).and_return new_v1_asset_xml(@story_data)
    puts new_v1_asset_xml(@story_data)
    @story = VersionOne.get_story(1)
  end
  
  it "should set the title of a story" do
    @story.title.should == @story_data.title
  end
  
  it "should set the owner of a story" do
    @story.owner.should == @story_data.owner
  end
  
  it "should set the estimate of a story" do
    @story.estimate.should == @story_data.estimate
  end
    
  it "should set the description of a story"
  it "should set the theme of a story"
  it "should set the iteration of a story"
  it "should set the story number"
end




