class StoriesController < ApplicationController
  layout "standard"

  def show
    @title = "Story"
    @story = VersionOne.get_story(session[:user],params[:story_no])
    if @story.title.blank?
      flash[:notice] = APP_CONFIG["NO_STORY_FOUND"]
      redirect_to :controller=>"search", :action=>"error"
    else
      @story
    end
  end
end
