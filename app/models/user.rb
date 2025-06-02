class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :post_images, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  # フォローしている関係
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
 
  # フォローされている関係
  has_many :reverse_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

   # フォローする
   def follow(other_user)
    return if self == other_user
    relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォローを外す
  def unfollow(other_user)
    relationships.find_by(followed_id: other_user.id)&.destroy
  end

  # フォローしているか確認
  def following?(other_user)
    followings.include?(other_user)
  end
end
