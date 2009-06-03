class StoriesController < ApplicationController
  layout "standard"

  def show
    @title = "Story"
    story_number = params[:story_no]
    user = session[:user]
    if request.post?
      @story = VersionOne.get_story(user,story_number)
      if @story.number.eql?""
        flash[:notice] = "No story found. Please refine your search."
        redirect_to :controller=>"login", :action =>"show"
      else
        @story
      end
    end
  end

end
