module FindDupeImages
  class Finder
    attr_reader :directory_path, :traversed_directories

    def self.run
      init
      define_path
      traverse_directory(@directory_path)
    end

    private

    def init
      @traversed_directories = []
    end

    def define_path
      @directory_path = FindDupeImages::Option.path
    end

    def traverse_directory(dir)
      Dir.glob(dir, File::FNM_DOTMATCH).each do |filename|
        traverse_directory(filename) if File.directory?(filename) && !@traversed_directories.include?(dir)
        @traversed_directories << dir
      end
    end
  end
end
