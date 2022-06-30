class UsersController < ApplicationController 
  before_action :set_user, except: [:index, :new]
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

  def index 
    @users = User.not_admins
  end

  def show 
    @reviews = @user.reviews 
    @favorite_movies = @user.favorite_movies
  end

  def new 
    @user = User.new 
  end

  def create 
    if @user.save 
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new 
    end
  end

  def edit 
  end

  def update 
    if @user.update(user_params)
      redirect_to @user, notice: 'Account successfully updated!'
    else
      render :edit
    end
  end

  def destroy 
    @user.destroy 
    session[:user_id] = nil 
    redirect_to movies_url, alert: 'Account deleted.'
  end
private 
  def user_params 
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end

  def set_user 
    @user = User.find(params[:id])
  end

  def require_correct_user
    unless current_user and current_user?(@user)
      redirect_to users_path, alert: 'Unauthorized Access.'
    end
  end
end