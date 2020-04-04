require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:roxane)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template "password_resets/new"
    assert_select "input[name=?]", "user[email]"
    post password_resets_path, params: {user: {email: ""}}
    assert_not flash.empty?
    assert_template "password_resets/new"
    post password_resets_path, params: {user: {email: @user.email}}
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_path
    user = assigns(:user)
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_path
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_path
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template "password_resets/edit"
    assert_select "input[name=email][type=hidden][value=?] ", user.email
    patch password_reset_path(user.reset_token), params: {user: {email: user.email, password: "foobaz", password_confirmation: "barquux"}}
    assert_select "div.invalid-feedback"
    patch password_reset_path(user.reset_token), params: {user: {email: user.email, password: "foobaz", password_confirmation: "foobaz"}}
    assert user.is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user_path(user)
  end
end
