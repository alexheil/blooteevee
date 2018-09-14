require "image_processing/mini_magick"

class ImageUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions

  plugin :determine_mime_type
  plugin :cached_attachment_data
  plugin :remove_attachment

  process(:store) do |io|
    original = io.download
    processor = ImageProcessing::MiniMagick

    size_600 = processor.source(original).resize_to_limit!(600, 600)
    size_100 = processor.source(size_600).resize_to_limit!(100, 100)

    original.close!

    { original: io, thumb: size_600, tiny: size_100 }
  end

  Attacher.validate do
    validate_max_size 15.megabyte, message: "is too large (max is 1 MB)"
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

end