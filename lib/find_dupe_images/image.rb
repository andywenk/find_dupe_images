module FindDupeImages
  class Image

    attr_accessor :image

    def initialize(image)
      @raw_image    = image
      @image_types  = %w(GIF JPEG PNG TIFF BMP ICO CUR PSD SVG WEBP)
      return unless is_image_and_not_too_big?
      read_image
    end

    def is_image?
      @image.is_a?(Magick::Image)
    end

    private

    def is_image_and_not_too_big?
      !image_is_too_big? && mime_is_image?
    end

    def image_is_too_big?
      if is_too_big?
        $too_big += 1
        FindDupeImages.logger.log({error: "The image #{@raw_image} is too big!"}.to_json)
        return true
      end
      false
    end

    def mime_is_image?
      fm = ::FileMagic.new(::FileMagic::MAGIC_MIME)
      mime_type = fm.file(@raw_image).split(';').first
      if FindDupeImages::IMAGE_MIME_TYPES.include?(mime_type)
        return true
      else
        $not_an_image += 1
        false
      end
    end

    def is_too_big?
      File.size?(@raw_image).to_f / (1024) > FindDupeImages::MAX_FILE_SIZE
    end

    def image_type
      @image.format
    end

    def read_image
      @image = read
    end

    def read
      begin
        Magick::Image.read(@raw_image).first
      rescue Magick::ImageMagickError => e
        FindDupeImages.logger.log({error: e.message}.to_json)
      end
    end
  end
end
