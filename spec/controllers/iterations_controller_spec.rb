require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IterationsController do

  before(:each) do
    @story1 = new_story("Story1")
    @story2 = new_story("Story2")
    @current_user = User.new("username","password")
    session[:user] = @current_user
    @iteration_number = {:iter=> "iteration1"}
    VersionOne.stub!(:get_stories_by_iteration).and_return [@story1, @story2]
  end

  it "responds to show" do
    get :show, :project => "project1",:itr_no=>@iteration_number
    response.should be_success
  end

  it "the assigned @stories should include Story1" do
     get :show, :project => "project1",:itr_no=>@iteration_number
    stories = assigns[:stories]
    stories.should have_a_story_with_title("Story1")
  end

  it "the assigned @stories should include Story2" do
    get :show, :project => "project1",:itr_no=>@iteration_number
    stories = assigns[:stories]
    stories.should have_a_story_with_title("Story2")
  end

  it "should redirect to the iterations show action" do
    get :show, :project => "project1",:itr_no=>@iteration_number
    response.should render_template("show")
  end

  it "should redirect to the search error action if project is blank" do
    get :show, :project => "",:itr_no=>@iteration_number
    flash[:notice].should_not be_nil
    response.should redirect_to(:controller=>"search",:action=>"error")
  end

  it "should redirect to the search error action if iteration number is blank" do
    get :show, :project => "",:itr_no=>@iteration_number
    flash[:notice].should_not be_nil
    response.should redirect_to(:controller=>"search",:action=>"error")
  end

  it "should redirect to the search error action if no story found" do
    stories = []
    VersionOne.stub!(:get_stories_by_iteration).and_return stories
    get :show, :project => "Project1",:itr_no=>@iteration_number
    flash[:notice].should_not be_nil
    response.should redirect_to(:controller=>"search",:action=>"error")
  end

end