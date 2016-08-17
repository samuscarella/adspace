class SessionsController < ApplicationController

  def index
  end

  def new
  end

  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to controller: 'posts', action: 'index'
    else
      flash[:login_error] = 'Username or Password is Invalid!'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private
  def authentication_params
    params.required(:session).permit(:username, :password)
  end

end
