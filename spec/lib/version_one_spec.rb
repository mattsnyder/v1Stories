require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'FakeWeb'

describe VersionOne, "find story by story number" do
  before(:each) do
    story_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
     "<Asset href=\"/expectmore/rest-1.v1/Data/Story/8006\" id=\"Story:8006\">" +
     "<Attribute name=\"Owners.Name\">" +
   	 "<Value>Jason Phillips</Value>" +
   	 "</Attribute>" +
   	 "<Attribute name=\"Estimate\">X-Large</Attribute>" +
   	 "<Attribute name=\"Description\">Default printing is difficult, so we need to make it easier.</Attribute>" +
     "<Attribute name=\"Name\">Enable card printing</Attribute>" +
     "<Attribute name=\"Scope.Name\">Version One Enhancements</Attribute>" +
     "<Attribute name=\"Timebox.Name\">Iteration 0</Attribute>" +
     "</Asset>"
     
   FakeWeb.register_uri(:get, "https://www10.v1host.com/expectmore/rest-1.v1/Data/Story/8006", :string => story_xml)
     
   #response = mock(:code => '200', :content_type => 'text/xml', :body => story_xml)
   #Net::HTTP.stub!(:get_response).with(URI.parse("https://www10.v1host.com/expectmore/rest-1.v1/Data/Story/8006")).and_return response
  
  end
  
  it "should return a hash of data" do 
    story_data = VersionOne.get_story(8006)
    story_data.should be_a(Hash)
  end
  
  it "should set the title of a story" do
    VersionOne.get_story(8006)[:title].should == "Enable card printing"
  end
  
  it "should set the owner of a story" do
    VersionOne.get_story(8006)[:owner].should == "Jason Phillips"
  end
  
  it "should set the estimate of a story" do
    VersionOne.get_story(8006)[:estimate].should == "X-Large"
  end
  
  it "should set the description of a story" do
    VersionOne.get_story(8006)[:description].should == "Default printing is difficult, so we need to make it easier."
  end
  
  it "should set the theme of a story" do
    VersionOne.get_story(8006)[:theme].should == "Version One Enhancements"
  end
  
  it "should set the iteration of a story" do
    VersionOne.get_story(8006)[:iteration].should == "Iteration 0"
  end
  
  it "should set the story number" do
    VersionOne.get_story(8006)[:number].should == "8006"
  end
end

describe VersionOne, "building the request url" do

  it "should append the story number to the V1 Story Data Url" do
    FakeWeb.register_uri(:get, "https://www10.v1host.com/expectmore/rest-1.v1/Data/Story/1212", :string => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
    puts VersionOne.get_story(1212).should be_empty
  end
  
end




