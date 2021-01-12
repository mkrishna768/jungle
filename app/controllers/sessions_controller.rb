class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # save user id as cookie
      session[:user_id] = user.id
      redirect_to '/'
    else
    # failed login
      redirect_to '/login'
    end
  end

  #logout
  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end