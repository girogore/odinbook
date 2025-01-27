class ImageUploader < Shrine
  # plugins and uploading logic
  ALLOWED_TYPES  = %w[image/jpeg image/png]
  MAX_SIZE       = 10*1024*1024 # 10 MB
  MAX_DIMENSIONS = [ 4000, 4000 ]

  plugin :remove_attachment
  plugin :pretty_location
  plugin :validation_helpers
  plugin :derivatives
  plugin :store_dimensions, log_subscriber: nil
  plugin :default_url
  plugin :determine_mime_type, analyzer: :mime_types

  Attacher.default_url do
    "default-240x300.jpg"
  end

  p Attacher.default_url

  # File validations (requires `validation_helpers` plugin)
  Attacher.validate do
    validate_size 0..MAX_SIZE

    if validate_mime_type ALLOWED_TYPES
      validate_max_dimensions MAX_DIMENSIONS
    end
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      tiny: magick.resize_to_fit!(64, 80),
      small:  magick.resize_to_fit!(240, 300),
      post: magick.resize_to_limit!(500, 500)
    }
  end
end
