class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates_uniqueness_of :user_id, scope: [ :likeable_id, :likeable_type ], message: "User already likes that Post/Comment"
  validates_presence_of :user, :likeable
end
