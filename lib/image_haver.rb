module ImageHaver
  include ImageUploader::Attachment(:image)

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
