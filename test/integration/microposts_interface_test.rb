require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:roxane)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select "ul.pagination"
    assert_no_difference "Micropost.count" do
      post microposts_path, params: {micropost: {content: ""}}
    end
    assert_select "div.invalid-feedback"
    assert_select "a[href=?]", "/?page=2"
    content = "This micropost really ties the room together."
    assert_difference "Micropost.count", 1 do
      post microposts_path, params: {micropost: {content: content}}
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_match content, response.body
    assert_select "a", text: "Delete"
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference "Micropost.count", -1 do
      delete micropost_path(first_micropost)
    end
    get user_path(users(:archer))
    assert_select "a", text: "Delete", count: 0
  end
end
