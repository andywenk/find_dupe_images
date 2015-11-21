module FindDupeImages
  class Finder
    attr_reader :directory_path, :traversed_directories

    class << self
      def run
        init
        define_path
        traverse_directory(@directory_path)
      end

      private

      def init
        @traversed_directories = []
      end

      def define_path
        @directory_path = FindDupeImages::Option.directory_path
      end

      def traverse_directory(dir)
        @traversed_directories << dir
        Dir.glob(dir, File::FNM_DOTMATCH).each do |filename|
          traverse_directory(filename) if File.directory?(filename) && !@traversed_directories.include?(filename)
          FindDupeImages.logger.log("checking_filename: #{filename}")
        end
      end
    end
  end
end
