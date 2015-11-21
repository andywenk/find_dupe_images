module FindDupeImages
  class Option
    def self.path
      puts ARGV[0]
      raise Error::DirectoryRequired unless File.directory?(ARGV[0])
    end
  end
end
