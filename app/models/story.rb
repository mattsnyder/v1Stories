class Story
  attr_accessor :number, :title, :theme, :description, :owner
  
  def Story.find(number)
    story_attributes = VersionOne.get_story(number)
    story_attributes.inject(Story.new) do |story,pair|
      key, value = pair
      story.send(key.to_s+"=", value)
      story
    end
  end
end
