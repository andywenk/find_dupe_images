module FindDupeImages
  class ProcessedData
    attr_reader :image_data, :hexdigest

    def initialize(data = {})
      @image_data = data.fetch(:image_data, nil)
      @hexdigest  = data.fetch(:hexdigest, nil)
    end
  end
end
