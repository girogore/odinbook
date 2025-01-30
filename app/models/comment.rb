class Comment < ApplicationRecord
  include ImageHaver
  before_save :image_resize
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates_presence_of :user, :post

  delegate :email, to: :user

  def is_liked?(user_id)
    self.likes.exists?([ user_id: user_id ])
  end

  def image_resize
    if self.image
      self.image_derivatives!
    end
  end

  def resized_image
    if self.image
      self.image(:small).url ? self.image(:small).url : self.image.url
    end
  end
end
