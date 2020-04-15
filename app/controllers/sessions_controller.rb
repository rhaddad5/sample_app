class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      if user.activated?
        log_in(user)
        params[:user][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or(root_path)
      else
        flash[:alert] = "Account not activated, check your emails for the activation link."
        redirect_to root_path
      end
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
