class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :following, dependent: :destroy
  has_many :followed_users, through: :following
  has_many :follow_requests, class_name: :Following, foreign_key: :followed_users_id

  def profile_picture_tiny
    profile.profile_photo_tiny
  end
end
