class ApplicationController < ActionController::Base

  add_flash_types :info, :success, :warning

  # before any action runs, it will first run this method
  before_action :set_current_user, :set_cache_headers

  private
  # if there is a session id i.e. user logged in then find it in db and assign it to instance var
  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    else
      redirect_to sign_in_path, warning: 'Please sign in first; or sign up if new user.'
    end
  end
  # if this fails then it will throw an error that it can't find that id in db if we used .find()
  # so we use .find_by() so that it doesn't crash the app

  # restrict going back to logged in app pages after logout by not storing the cache
  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  end
end
