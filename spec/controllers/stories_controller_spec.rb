require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  before(:each) do
    @story = Story.new
    Story.stub!(:find).and_return @story
  end
  
  it "responds to show" do
    get :show, :number => 1
    response.should be_success
  end
  
  it "assigns the found Story to @story" do
    get :show, :number => 1
    assigns[:story].should be(@story)
  end

end
