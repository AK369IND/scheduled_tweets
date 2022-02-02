class MainController < ApplicationController
  def index
    if Current.user
      flash[:info] = 'Logged in successfully.'
    end
  end
end
