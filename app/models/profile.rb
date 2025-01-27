class Profile < ApplicationRecord
  include ImageUploader::Attachment(:image)
  before_save :image_resize
  belongs_to :user

  delegate :email, :followed_users, :comments, :posts,  to: :user

  def image_resize
    if self.image
      self.image_derivatives!
    end
  end

  def profile_photo
    if self.image
      self.image(:small).url ? self.image(:small).url : self.image.url
    else
      "default-300x240.jpg"
    end
  end

  def profile_photo_tiny
    if self.image
      self.image(:tiny).url ? self.image(:tiny).url : self.image.url
    else
      "default-80x64.jpg"
    end
  end
end
