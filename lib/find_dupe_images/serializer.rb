module FindDupeImages
  class Serializer

    attr_reader :processed_image_data

    def initialize(processed_image_data = nil)
      @processed_image_data   = processed_image_data
      @serialize_filename     = 'serialized.marshal'
      @seperator              = "---_---"
    end

    def serialize
      File.open(serialize_to_file, 'a') do |file|
        file.print Marshal::dump(@processed_image_data)
        file.print @seperator
      end
    end

    def deserialize
      $/          = @seperator
      hexdigests  = {}
      hits        = {}

      return hits unless File.exist?(serialize_to_file)

      File.open(serialize_to_file, 'r').each do |object|
        o = Marshal::load(object.chomp)
        if hexdigests.has_key?(o.hexdigest)
          hits[o.hexdigest] = "#{o.file_name} is a duplicate of #{hexdigests[o.hexdigest].join(' and ')}"
        end
        if hexdigests[o.hexdigest].is_a?(Array)
          hexdigests[o.hexdigest] << o.file_name
        else
          hexdigests[o.hexdigest] = [o.file_name]
        end
      end

      hits
    end

    def remove_marshal_file
      File.unlink(serialize_to_file) if File.file?(serialize_to_file)
    end

    private

    def serialize_to_file
      Pathname.new([File.expand_path('../../', __FILE__), @serialize_filename].join(''))
    end
  end
end
