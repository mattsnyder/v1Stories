require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LoginController do

  before(:each) do
    LoginController.skip_before_filter :require_login 
  end

  it "should use LoginController" do
    controller.should be_an_instance_of(LoginController)
  end

  it "should be successful" do
    get 'login'
    response.should be_success
  end

  context "when authenticating valid user" do
    integrate_views
    it "should redirect to search show" do
     VersionOne.stub!(:authenticate_user).and_return false
     post:login, :username =>"developer",:password=>"developer"
     response.should redirect_to(:controller=>"search",:action=>"show")
    end
  end

  context "when authenticating invalid user" do
    integrate_views
    it "should redirect to search show" do
     VersionOne.stub!(:authenticate_user).and_return true
     post:login, :username =>"developer",:password=>"developer"
     flash[:notice].should_not be_nil
     response.should redirect_to(:action=>"login")
    end
  end

end
