class IterationsController < ApplicationController
layout "standard" , :except => [ :iterations ]
  def show
    @title = "Stories"
    itr_no = params[:itr_no]
    if params[:project].eql? "" or itr_no.eql?"" or itr_no[:iter].eql? ""
     flash[:notice] = "Please select a project and an iteration."
     redirect_to :controller => "login", :action => "show"
    else
      stories = VersionOne.get_stories_by_iteration(session[:user],params[:project_name],itr_no[:iter])
      @stories = stories
    end

  end

  def iterations
    @iterations = VersionOne.get_iterations_for_project(session[:user],params[:project])
    respond_to do |format|
      format.js
    end
  end

end
