class UsersController < ApplicationController

  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      puts @user
      session[:user_id] = @user.id
      redirect_to controller: 'posts', action: 'index'
    else
      render 'users/new', error: 'Failed to Create User'
    end
  end

  def new
    @user = User.new
  end

  def show
  end

  private
  def user_params
    params.required(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
