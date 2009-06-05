class LoginController < ApplicationController

  def login
    @title = "Login"
    if request.post?
      @user = User.new(params[:username],params[:password])
      if VersionOne.authenticate_user(@user)
        flash[:notice] = APP_CONFIG["INVALID_LOGIN"]
        redirect_to :action => "login"
      else
        session[:user] = @user
        redirect_to(:controller=> "search",:action => "show")
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = APP_CONFIG["LOGOUT"]
    render :action => "login"  
  end
  
end
