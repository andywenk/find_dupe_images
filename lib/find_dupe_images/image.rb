module FindDupeImages
  class Image

    attr_accessor :image

    def initialize(image)
      @image_types  = %w(GIF JPEG PNG TIFF BMP ICO CUR PSD SVG WEBP)
      @image        = read(image)
    end

    def is_image?
      return false unless @image.is_a?(Magick::Image)
      @image_types.include?(image_type)
    end

    private

    def image_type
      #IO.popen(["file", "--brief", "--mime-type", '/Users/andwen/Pictures/Andy/team-internet.jpg'], in: :close, err: :close) { |io| io.read.chomp }
      @image.format
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
