require "find_dupe_images/version"
require "find_dupe_images/options"
require "find_dupe_images/finder"

module FindDupeImages
  def self.execute
    FindDupeImages::Finder.run
  end
end
