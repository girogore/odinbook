class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  include ImageHaver
  before_save :image_resize
  delegate :email, to: :user

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
