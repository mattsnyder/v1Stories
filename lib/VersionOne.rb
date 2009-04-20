class VersionOne
  def self.get_story(number)
    story = Story.new
    story.title = "Add support for printing cards"
    story.owner = "Jason Phillips"
    story.estimate = "X-Large"
    story
  end
end