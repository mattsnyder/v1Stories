# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def trim_story_description(description)
    truncate(description, :length => 250, :omission => "...")
  end
end
