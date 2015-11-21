module FindDupeImages
  class Image

    def initialize(image)
      @image_types  = %w(GIF JPEG PNG TIFF BMP ICO CUR PSD SVG WEBP)
      @image        = image
    end

    def is_image?
      return false unless File.file?(@image)
      @image_types.include?(image_type)
    end

    private

    def image_type
      Magick::Image.read(@image).first.format
    end
  end
end
