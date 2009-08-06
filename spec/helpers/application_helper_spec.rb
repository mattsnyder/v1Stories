require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper, "trim_story_title" do
  include ApplicationHelper
  it "should NOT trim a long title" do
    trim_story_title("X"*50).should end_with("X") 
    trim_story_title("X"*50).length.should == 50 
  end
end
  
describe ApplicationHelper, "trim_story_description" do
  include ApplicationHelper
    
  it "should leave a string a short string alone" do
    trim_story_description("a short line of text").should end_with("text")
  end
  
  it "should leave a string at the max length alone" do
    string_with_length_250 = "If the first symbol  listed is chosen,  then any or all of the symbols following can be used as well. For example, for Liability, if symbol  7 is chosen, then the user can also choose  8, 9, or 19. The user can choose any one or all of those symbols."
    string_with_length_250.length.should == 250
    trim_story_description(string_with_length_250).should end_with("symbols.")
  end

  it "should NOT trim a long string" do
  string = <<-LONG_STRING
  If the first symbol listed is chosen, then any or all of the symbols following can be used as well. 
  For example, for Liability, if symbol 7 is chosen, then the user can also choose  8, 9, or 19. The user 
  can choose any one or all of those symbols. More text to make this longer.
  LONG_STRING
  trim_story_description(string).should end_with("this longer.")
  end
end