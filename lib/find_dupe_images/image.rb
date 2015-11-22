module FindDupeImages
  class Image
    attr_accessor :read_image

    def initialize(image)
      @image_types  = %w(GIF JPEG PNG TIFF BMP ICO CUR PSD SVG WEBP)
      @image        = image
    end

    def read
      begin
        @read_image = Magick::Image.read(@image).first
      rescue Magick::ImageMagickError => e
        FindDupeImages.logger.log({error: e.message}.to_json)
      end
    end

    def is_image?
      return false unless File.file?(@read_image)
      @image_types.include?(image_type)
    end

    private

    def image_type
      @read_image.format
    end
  end
end
