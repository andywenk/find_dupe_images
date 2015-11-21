require "logger"
require "logstash-logger"
require 'digest/md5'
require 'rmagick'
require "find_dupe_images/logger"
require "find_dupe_images/version"
require "find_dupe_images/error/base"
require "find_dupe_images/image"
require "find_dupe_images/option"
require "find_dupe_images/finder"

module FindDupeImages
  def self.execute
    begin
      Finder.run
    rescue Error::DirectoryRequired
    end
  end

  def self.logger
    FindDupeImages::Logger.new
  end
end
