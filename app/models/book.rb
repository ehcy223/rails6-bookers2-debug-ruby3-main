class Book < ApplicationRecord
  belongs_to :user 
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_one_attached :book_image

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
