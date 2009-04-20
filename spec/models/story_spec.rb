require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story do
  before(:each) do
    @valid_attributes = {
      :number => 5,
      :title => "Print a card",
      :theme => "Version One Extensions",
      :description => "Jason wants to see a story from version one so he can print it.", 
      :owner => 'Cool like cats'
    }
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
  
  it "hs a description" do
    @story.description.should == @valid_attributes[:description]
  end
  
  it "has an owner" do
    @story.owner.should == @valid_attributes[:owner]
  end
end
