class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    raise
    if user && user.authenticate(params[:user][:password])
      log_in(user)
      params[:user][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to user_path(user)
    else
      flash.now[:alert] = "Invalid email/password combination"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
