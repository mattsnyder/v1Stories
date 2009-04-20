require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe VersionOne, "find story by story number" do
  before(:each) do
    
  end
  
  it "should set the title of a story" do
    VersionOne.stub!(:request_xml).and_return new_v1_asset_xml_with_attribute("name","Add support for printing cards")
    story = VersionOne.get_story(1)
    story.title.should == "Add support for printing cards"
  end
  
  it "should set the owner of a story"
  it "should set the estimate of a story"
  it "should set the description of a story"
  it "should set the theme of a story"
  it "should set the iteration of a story"
  it "should set the story number"
end




