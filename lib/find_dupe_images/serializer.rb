module FindDupeImages
  class Serializer

    attr_reader :processed_image_data

    def initialize(processed_image_data)
      @processed_image_data   = processed_image_data
      @serialize_filename     = 'serialized.marshal'
    end

    def serialize
      File.open(serialize_to, 'a') do |file|
        file.print Marshal::dump(@processed_image_data)
        file.print "---_---"
      end
    end

    private

    def serialize_to
      Pathname.new([File.expand_path('../../', __FILE__), @serialize_filename].join(''))
    end
  end
end
