require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LoginController, "authenticating valid user login" do
  before(:each) do
    @valid_user = true
    VersionOne.stub!(:authenticate_user).and_return @valid_user
  end

  it "should show the home page" do

  end
  it "should store the user in session" do

  end

end

describe LoginController, "authenticating invalid user login" do
  before(:each) do
    @valid_user = false
    VersionOne.stub!(:authenticate_user).and_return @valid_user
  end

  it "should show the login page" do

  end
  it "should display the error message" do

  end

end