class PasswordResetsController < ApplicationController
  before_action :get_user_edit, only: :edit
  before_action :get_user_update, only: :update
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = "Email sent with password reset instructions"
      redirect_to root_path
    else
      flash.now[:alert] = "Email address not found"
      render "new"
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
    elsif @user.update(user_params)
      log_in(@user)
      flash[:notice] = "Your password has been reset."
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user_edit
    @user = User.find_by(email: params[:email])
  end

  def get_user_update
    @user = User.find_by(email: params[:user][:email])
  end

  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_path
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:alert] = "Password reset has expired."
      redirect_to new_password_reset_path
    end
  end
end
