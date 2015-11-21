module FindDupeImages
  module Error
    class Base < StandardError
      def initialize(error_message = '')
        super(error_message)
        puts "ERROR: #{error_message}"
      end
    end
    
    class DirectoryRequired < Base
      def initialize
        super('Please provide a directory')
      end
    end
  end
end
