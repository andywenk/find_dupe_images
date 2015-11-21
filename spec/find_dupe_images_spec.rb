require 'spec_helper'

describe FindDupeImages do

  it 'is described module' do
    expect(described_class).to eq(FindDupeImages)
  end

  it 'has a version number' do
    expect(FindDupeImages::VERSION).not_to be nil
  end

end
