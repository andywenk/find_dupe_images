module FindDupeImages
  class Option
    def self.path
      raise Error::DirectoryRequired unless File.directory?(ARGV[0])
    end
  end
end
