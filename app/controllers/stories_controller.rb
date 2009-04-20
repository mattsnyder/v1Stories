class StoriesController < ApplicationController
  def show
    story_number = params[:number]
    @story = Story.find(story_number)
  end
end
