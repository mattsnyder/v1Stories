class IterationsController < ApplicationController
  def show
    stories = Story.find_by_iteration(params[:number])
    @stories = stories
  end
end
