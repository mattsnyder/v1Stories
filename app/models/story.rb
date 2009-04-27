class Story
  attr_accessor :number, :title, :theme, :description, :owner, :estimate, :iteration
  
  def self.find(number)
    story_attributes = VersionOne.get_story(number)
    story_attributes.inject(Story.new) do |story,pair|
      key, value = pair
      story.send(key.to_s+"=", value.to_s.strip_tags)
      story
    end
  end
  
  def self.find_by_iteration(number)
    iteration = VersionOne.get_stories_by_iteration(number)
    
    iteration[:stories].map do |story|
      story.inject(Story.new) do |story,pair|
        key, value = pair
        story.send(key.to_s+"=", value.to_s.strip_tags)
        story
      end
      
    end
  end
end
