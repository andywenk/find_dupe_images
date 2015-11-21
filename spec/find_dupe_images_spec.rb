require 'spec_helper'

describe FindDupeImages do

  it 'is described module' do
    expect(described_class).to eq(FindDupeImages)
  end

  it 'has a version number' do
    expect(FindDupeImages::VERSION).not_to be nil
  end

  it 'has methods' do
    expect(FindDupeImages.respond_to?(:execute)).to be_truthy
  end
end
