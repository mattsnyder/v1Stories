require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController do
  integrate_views
  before(:each) do
    @current_user = User.new("username","password")
    session[:user] = @current_user
    @story = new_story("title") 
    VersionOne.stub!(:get_story).and_return @story
  end
  
  it "responds to show" do
    get :show, :number => 1
    response.should be_success
  end

  it "assigns the found Story to @story" do
    get :show, :number => 1
    assigns[:story].should be(@story)
  end

  it "should render the show template" do
    get :show, :number => 1
    response.should render_template("show")
  end

  it "should redirect to the search show action" do
    @story = new_story("")  
    VersionOne.stub!(:get_story).and_return @story
    get :show, :number => 1
    flash[:notice].should_not be_nil
    response.should redirect_to(:controller=>"search",:action=>"error")
  end

end
