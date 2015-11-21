module FindDupeImages
  class Finder
    attr_reader :directory_path, :image_data, :hexdigest

    class << self
      def run
        init
        define_path
        define_directory
        traverse_directory(@directory_path)
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
            read_image_data(filename)
            create_hexdigest
          end
        end
      end

      def read_image_data(filename)
        @image_data = MiniMagick::Image.read(filename.to_s).first
      end

      def create_hexdigest
        @hexdigest = Digest::MD5.hexdigest @image_data.export_pixels.join
      end
    end
  end
end
