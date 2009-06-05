class IterationsController < ApplicationController
layout "standard" , :except => [ :iterations ]
  def show
    @title = "Stories"
    itr_no = params[:itr_no]
    if params[:project].nil? or itr_no.nil? or params[:project].blank? or itr_no[:iter].blank?
     flash[:notice] = APP_CONFIG["PROJECT_OR_ITRERATION_MISSING"]
     redirect_to :controller=>"search",:action=>"error" 
    else
      stories = VersionOne.get_stories_by_iteration(session[:user],params[:project_name],itr_no[:iter])
      @stories = stories
      if @stories.empty?
        flash[:notice] = APP_CONFIG["NO_STORY_FOUND"]
        redirect_to :controller=>"search",:action=>"error"
      else
         @stories
      end
    end
  end 

  def iterations
    @iterations = VersionOne.get_iterations_for_project(session[:user],params[:project])
    respond_to do |format|
      format.js
    end
  end

end
