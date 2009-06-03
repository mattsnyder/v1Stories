class LoginController < ApplicationController
 
  def show
    @title = "Search"
    @current_user = find_user
    @projects = VersionOne.get_project(find_user)
  end

  def login
    @title = "Login"
    if request.post?   
      @user = User.new(params[:username],params[:password])
      if VersionOne.authenticate_user(@user)
        flash[:notice] = "Unable to log in. Incorrect username or password.Please try again."
        redirect_to :action => "login"
      else
        session[:user] = @user
        redirect_to(:action => "show")
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = "User has been successfully logged out."
    redirect_to :action => "login"
  end
  

  private
  
  def find_user
    session[:user]
  end


end
