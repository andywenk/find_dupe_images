module FindDupeImages
  class Option
    def self.directory_path
      raise Error::DirectoryRequired unless File.directory?(ARGV[0])
      ARGV[0]
    end
  end
end
