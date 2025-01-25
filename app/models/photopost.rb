class Photopost < Post
  include ImageUploader::Attachment(:image)
end
