class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
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