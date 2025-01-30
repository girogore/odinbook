class Following < ApplicationRecord
  belongs_to :user
  belongs_to :followed_users, class_name: :User

  validates :status, inclusion: { in: %w[requested approved rejected] }
  validates_uniqueness_of :user, scope: [ :followed_users ], message: "You already have a follow request for that user."
end
