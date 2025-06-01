class PostImage < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user

  has_one_attached :image  

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
