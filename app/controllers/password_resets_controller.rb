class PasswordResetsController < ApplicationController
  
  skip_before_action :set_current_user, only: [:new, :create, :edit, :update]

  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    
    if @user.present?
      # send the reset email
      # passing with args as email to Password mailer and invoking the reset but do this in background 
      PasswordMailer.with(user: @user).reset.deliver_later

      # .deliver_now if don't want to send in background
    end
    redirect_to sign_in_path, info: 'If an account with that email exists, it has received a password reset mail.'
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  # if find_signed! throws the following error of token expiration
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, warning: 'Your password reset token has expired.'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    if params[:user][:password].present? && @user.update(password_params)
      redirect_to sign_in_path, success: 'Your password was reset successfully.'
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end