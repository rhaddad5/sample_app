class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  default_scope {order(created_at: :desc)}
  has_one_attached :image
  validates :image, content_type: {in: ["image/jpeg", "image/gif", "image/png"], message: "Must be a valid image format."}, size: {less_than: 5.megabytes, message: "Should be less than 5MB."}

  def display_image
    image.variant(resize_to_limit: [500, 500])
  end
end
