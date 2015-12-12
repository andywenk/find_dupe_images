require "logger"
require "logstash-logger"
require 'digest/md5'
require 'rmagick'
require 'pathname'
require 'yaml'
require 'filemagic'
require "find_dupe_images/logger"
require "find_dupe_images/version"
require "find_dupe_images/image_mime_types"
require "find_dupe_images/error/base"
require "find_dupe_images/image"
require "find_dupe_images/option"
require "find_dupe_images/finder"
require "find_dupe_images/serializer"
require "find_dupe_images/processed_data"

# FindDupeImages
#
# this is the main entry
module FindDupeImages

  # some definitions.
  # @TODO Should be refactored to a FindDupeImages::Configuration
  #
  MAX_FILE_SIZE = 8000 #in kb
  $count        = 0
  $too_big      = 0
  $not_an_image = 0

  # The only public interface method to run the scan
  #
  # @return
  def self.execute
    begin
      Finder.run
    rescue Error::DirectoryRequired
    end
  end

  # create a logger
  def self.logger
    FindDupeImages::Logger.new
  end
end
