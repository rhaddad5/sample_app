class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:notice] = "Your account was successfully activated!"
      redirect_to user_path(@user)
    else
      flash[:alert] = "Invalid activation link"
      redirect_to root_path
    end
  end
end
