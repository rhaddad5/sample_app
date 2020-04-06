class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = "Please log in."
      redirect_to login_path
    end
  end
end
