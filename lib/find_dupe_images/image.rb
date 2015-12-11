module FindDupeImages
  class Image

    attr_accessor :image

    def initialize(image)
      @image_types  = %w(GIF JPEG PNG TIFF BMP ICO CUR PSD SVG WEBP)
      return if image_is_too_big?(image)
      read_image(image)
    end

    def is_image?
      return false unless @image.is_a?(Magick::Image)
      @image_types.include?(image_type)
    end

    private

    def image_is_too_big?(image)
      too_big = File.size?(image).to_f / (1024) > 8000
      if too_big
        FindDupeImages.logger.log({error: "The image #{image} is too big!"}.to_json)
      end
      too_big
    end

    def image_type
      @image.format
    end

    def read_image(image)
      @image = read(image)
    end

    def read(image)
      begin
        Magick::Image.read(image).first
      rescue Magick::ImageMagickError => e
        FindDupeImages.logger.log({error: e.message}.to_json)
      end
    end
  end
end
