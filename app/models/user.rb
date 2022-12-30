class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :followed_relations, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_relations, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :followed_relations, source: :followed
  has_many :followers, through: :follower_relations, source: :follower
  
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def relation_by?(user)
    follower_relations.exists?(follower_id: user.id)
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
