class Post < ApplicationRecord
  include ImageHaver
  before_save :image_resize
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  delegate :email, to: :user

  scope :date_sorted, -> { order("created_at DESC") }
end
