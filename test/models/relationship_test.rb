require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase

  def setup
    @relationship = Relationship.new(follower_id: users(:michael).id, followed_id: users(:roxane).id)
  end

  test "should be valide" do
    assert @relationship.valid?
  end

  test "should reuire a follower_id" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "should reuire a followed_id" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
