module FindDupeImages
  class Finder
    attr_reader :directory_path, :image_data, :hexdigest

    class << self
      def run
        init
        define_path
        define_directory
        traverse_directory
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

      def traverse_directory
        FindDupeImages::Serializer.new.remove_marshal_file

        puts "\nStarting to process #{@directory.size} files in the directory ...\n\n"

        @directory.each do |filename|
          @image = FindDupeImages::Image.new(filename)

          if @image.is_image?
            read_image_data(filename)
            $count += 1
            log_data(filename)
            serialize_data
          end

          trap("SIGINT") do
            puts 'Interrupted! Closing.'
            exit(0)
          end
        end
      end

      def log_data(filename)
        create_hexdigest
        FindDupeImages.logger.log(processed_image_data.to_json)
      end

      def read_image_data(filename)
        @image_data = @image.image
      end

      def create_hexdigest
        @hexdigest = Digest::MD5.hexdigest @image_data.export_pixels_to_str
      end

      def processed_image_data
        {image_data: @image_data.inspect, hexdigest: @hexdigest}
      end

      def serialize_data
        FindDupeImages::Serializer.new(FindDupeImages::ProcessedData.new({file_name: @image_data.filename, hexdigest: @hexdigest})).serialize
      end

      def result
        results = FindDupeImages::Serializer.new.deserialize
        create_report(results)
      end

      def create_report(results)
        results.size > 0 ? with_duplicates(results) : without_duplicates
        puts "\nReport:"
        files_too_big
        not_an_image
      end

      def with_duplicates(results)
        puts "\n\nThe following files have been detected as duplicates:\n\n"
        results.each_pair do |hexdigest, file|
          puts file
        end
      end

      def without_duplicates
        puts "\tNo files have been detectad as duplicates"
      end

      def files_too_big
        if $too_big > 0
          puts "\t#{$too_big} files have been ignored because they are too big!"
        end
      end

      def not_an_image
        if $not_an_image > 0
          puts "\t#{$not_an_image} files have been ignored because they are not recognized as an image!"
        end
      end
    end
  end
end
