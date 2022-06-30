class SessionsController < ApplicationController 
  def new    
  end

  def create 
    user = User.find_by(email: params[:email_or_username]) || User.find_by(username: params[:email_or_username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect_to (session[:intended_url] || movies_path), notice: "Welcome back, #{user.name.upcase}"
      session[:intended_url] = nil
    else
      flash.now[:alert] = 'Invalid credentials.'
      render :new 
    end
  end

  def destroy 
    session[:user_id] = nil 
    redirect_to movies_url, notice: 'Signed out.'
  end
end