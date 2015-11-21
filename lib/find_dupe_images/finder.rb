module FindDupeImages
  class Finder
    attr_reader :directory_path, :image_data, :hexdigest

    class << self
      def run
        init
        define_path
        define_directory
        traverse_directory(@directory_path)
        result
      end

      private

      def init
        @traversed_directories = []
      end

      def define_path
        @directory_path = FindDupeImages::Option.directory_path
      end

      def define_directory
        @directory = Dir.glob("#{@directory_path}**/*").reject { |fn| File.directory?(fn)}
      end

      def traverse_directory(dir)
        @directory.each do |filename|
          if FindDupeImages::Image.new(filename).is_image?
            log_data(filename)
            serialize_data
          end
        end
      end

      def log_data(filename)
        read_image_data(filename)
        create_hexdigest
        FindDupeImages.logger.log(processed_image_data.to_json)
      end

      def read_image_data(filename)
        @image_data = Magick::Image.read(filename.to_s).first
      end

      def create_hexdigest
        @hexdigest = Digest::MD5.hexdigest @image_data.export_pixels.join
      end

      def processed_image_data
        {image_data: @image_data.inspect, hexdigest: @hexdigest}
      end

      def serialize_data
        FindDupeImages::Serializer.new(FindeDupeImages::ProcessedData.new({image_data: @image_data, hexdigest: @hexdigest})).serialize
      end

      def result
        puts 'DONE!'
      end
    end
  end
end
