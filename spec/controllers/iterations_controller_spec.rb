require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IterationsController do

  before(:each) do
    @story1 = new_story("Story1")
    @story2 = new_story("Story2")
    Story.stub!(:find_by_iteration).and_return [@story1, @story2]
  end

  it "responds to show" do
    get :show, :number => 1
    response.should be_success
  end

  it "the assigned @stories should include Story1" do
    get :show, :number => 1
    stories = assigns[:stories]
    stories.should have_a_story_with_title("Story1")
  end
  
  it "the assigned @stories should include Story2" do
    get :show, :number => 1
    stories = assigns[:stories]
    stories.should have_a_story_with_title("Story2")
  end
end
