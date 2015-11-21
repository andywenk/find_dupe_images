module FindDupeImages
  class Logger
    attr_accessor :log_level

    def initialize(log_level: :debug, log_file: 'find_dupe_images.log')
      log_levels = %i(debug info warn error fatal)
      raise ArgumentError.new("log_level must be ohne of #{log_levels.join(', ')}") unless log_levels.include?(log_level)

      self.log_level = log_level
      @@logger ||= ::LogStashLogger.new(type: :file, path: log_file, sync: true)
      #@@logger ||= ::Logger.new(log_file)
    end

    def log(message, log_level: self.log_level)
      @@logger.send(log_level, message.force_encoding('UTF-8'))
    end
  end
end
