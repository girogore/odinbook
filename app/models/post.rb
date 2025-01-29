class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  include ImageHaver
  before_save :image_resize
  delegate :email, to: :user
  scope :date_sorted, -> { order("created_at DESC") }
end
