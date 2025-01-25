class Following < ApplicationRecord
  belongs_to :user
  belongs_to :followed_users, class_name: :User

  validates :status, inclusion: { in: %w[requested approved rejected] }
end
