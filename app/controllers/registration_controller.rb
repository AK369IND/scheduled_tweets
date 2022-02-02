class RegistrationController < ApplicationController

  skip_before_action :set_current_user, only: [:new, :create]
  
  def new
    @new_user = User.new  # User class object used to mention model in form in new.html
  end

  def create
    # to save the retrieved form data of params into db, we have to use .save method of
    # ApplicationRecord class (via an object) which is already inherited into User class
    @new_user = User.new(user_params)

    # @new_user object now has the ability to save data in itself into db
    if @new_user.save
      # save the db user_id in encrypted session cookies to check logged in anywhere
      session[:user_id] = @new_user.id
      redirect_to root_path, info: 'Signed Up successfully!'
    else
      # reload the form page new.html(but with errors shown- code handled in the new file itself)
      render :new
    end
  end

  private

  # this is created for security and ease
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
    # params.require(:user) is same as params[:user] but also raises an error if no such key found
    # .permit() only allows the args written above to be entered into params hash
  end
end
