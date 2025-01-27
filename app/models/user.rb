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

  def follow_status(followed_users_id)
    record = self.following.find_by(followed_users_id: followed_users_id.to_s)
    if record
      record.status
    else
      nil
    end
  end

  def follow_status_reverse(user_id)
    record = self.follow_requests.find_by(user_id: user_id.to_s)
    if record
      record.status
    else
      nil
    end
  end

  def profile_picture_tiny
    profile.profile_photo_tiny
  end
end
