require "logger"
require "logstash-logger"
require 'digest/md5'
require 'rmagick'
require 'pathname'
require 'yaml'
require "find_dupe_images/logger"
require "find_dupe_images/version"
require "find_dupe_images/error/base"
require "find_dupe_images/image"
require "find_dupe_images/option"
require "find_dupe_images/finder"
require "find_dupe_images/serializer"
require "find_dupe_images/processed_data"

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
