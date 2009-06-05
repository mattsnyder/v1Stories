# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def trim_story_description(description)
    truncate(description, :length => 220, :omission => "...")
  end
  
  def trim_story_title(title)
    truncate(title, :length => 100, :omission => "...")
  end
end
