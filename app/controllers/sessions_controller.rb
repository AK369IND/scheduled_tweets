class SessionsController < ApplicationController

  skip_before_action :set_current_user, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    # check if user exists in db with this email and password using .authenticate method of 
    # 'has_secure_password' we declared in user model
    if @user.present? && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, info: 'Logged in successfully.'
    else
      flash[:warning] = 'Invalid email or password.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path, info: 'Logged out successfully.'
  end
end