module FindDupeImages
  class ProcessedData
    attr_reader :file_name, :hexdigest

    def initialize(data = {})
      @file_name  = data.fetch(:file_name, nil)
      @hexdigest  = data.fetch(:hexdigest, nil)
    end
  end
end
