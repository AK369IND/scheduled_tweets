class PasswordsController < ApplicationController

  def edit

  end

  def update
    if params[:user][:password].present? && Current.user.update(password_params)
      redirect_to root_path, success: 'Password updated successfully.'
    else
      flash[:warning] = 'Invalid password'
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end