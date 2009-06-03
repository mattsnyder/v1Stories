require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'FakeWeb'

describe VersionOne, "find story by story number" do
  before(:each) do

   @user = User.new("grange1","ohiostate")
   asset_xml = new_asset_xml(new_story_data("Enable card printing",
   "Default printing is difficult, so we need to make it easier.",
   "Version One Enhancements",
   "Jason Phillips",
   "X-Large",
   "Iteration 0",
   "8006"))

   story_xml = <<-XML
    <?xml version="1.0" encoding="UTF-8"?>
     <Assets>
       #{asset_xml}
     </Assets>
    XML

   FakeWeb.register_uri(:get, "https://www10.v1host.com/expectmore/rest-1.v1/Data/Story?where=Number='8006'", :string => story_xml)
  end

  it "should return a hash of data" do
    story = VersionOne.get_story(@user,8006)
    story.should be_a(Story)  
  end

  it "should set the title of a story" do
    VersionOne.get_story(@user,8006).title.should == "Enable card printing"
  end

  it "should set the owner of a story" do
    VersionOne.get_story(@user,8006).owner.should == "Jason Phillips"
  end

  it "should set the estimate of a story" do
    VersionOne.get_story(@user,8006).estimate.should == "X-Large"
  end

  it "should set the description of a story" do
    VersionOne.get_story(@user,8006).description.should == "Default printing is difficult, so we need to make it easier."
  end

  it "should set the theme of a story" do
    VersionOne.get_story(@user,8006).theme.should == "Version One Enhancements"
  end

  it "should set the iteration of a story" do
    VersionOne.get_story(@user,8006).iteration.should == "Iteration 0"
  end

  it "should set the story number" do
    VersionOne.get_story(@user,8006).number.should == "8006"
  end
end

describe VersionOne, "building the request url" do

  it "should append the story number to the V1 Story Data Url" do
    @user = User.new("","")
    FakeWeb.register_uri(:get, "https://www10.v1host.com/expectmore/rest-1.v1/Data/Story?where=Number='1212'", :string => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
    VersionOne.get_story(@user,1212).number.eql? ""
  end

end

describe VersionOne, "retrieving stories by iteration" do
  before(:each) do
    
    @user = User.new("","")
    @story1 = new_story_data("Enable card printing",
     "Default printing is difficult, so we need to make it easier.",
     "Version One Enhancements",
     "Jason Phillips",
     "Small",
     "Iteration 1",
     "8006")

     @story2 = new_story_data("Print on a 4x6 card",
      "Make it look like a real story card by printing on an index card",
      "Version One Enhancements",
      "Jason P.",
      "Large",
      "Iteration 1",
      "3412")

     story_xml = <<-XML
     <?xml version="1.0" encoding="UTF-8"?>
      <Assets>
        #{new_asset_xml(@story1)}
        #{new_asset_xml(@story2)}
      </Assets>
     XML

   FakeWeb.register_uri(:get, "https://www10.v1host.com/expectmore/rest-1.v1/Data/Story?where=Timebox.Name=%27Iteration+1%27", :string => story_xml)
  end

  it "has a method get_stories_by_iteration" do
    VersionOne.should respond_to(:get_stories_by_iteration)
  end

  it "should contain 3 stories" do
    stories = VersionOne.get_stories_by_iteration(@user,'Iteration 1')
    stories.size == 3
  end

  it "should contain the first story" do
    stories = VersionOne.get_stories_by_iteration(@user,'Iteration 1')
    stories
  end

  it "should contain a second story" do
    VersionOne.get_stories_by_iteration(@user,'Iteration 1').should include(@story2)
  end
end

describe VersionOne, "retrive a different iteration" do
  before (:each) do
    story_xml = <<-XML
              <?xml version="1.0" encoding="UTF-8"?>
              <Assets>
              </Assets>
              XML

    FakeWeb.register_uri(:get, "https://www10.v1host.com/expectmore/rest-1.v1/Data/Story?where=Timebox.Name=%27Iteration+30%27", :string => story_xml)
  end

  it "should update the request url to use this iterations name" do
    @user = User.new("","")
    VersionOne.get_stories_by_iteration(@user,'Iteration 30').size == 0
  end
end




