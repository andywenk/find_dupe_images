module FindDupeImages
  class Option
    def self.directory_path
      raise Error::DirectoryRequired if ARGV.nil? || ARGV[0].nil? || !File.directory?(ARGV[0])
      ARGV[0]
    end
  end
end
