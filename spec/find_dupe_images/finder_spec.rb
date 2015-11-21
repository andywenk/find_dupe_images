require 'spec_helper'

describe FindDupeImages::Finder do
  it 'is described class' do
    expect(described_class).to eql(FindDupeImages::Finder)
  end

  it 'has methods' do
    expect(FindDupeImages::Finder.respond_to?(:run)).to be_truthy
    expect(FindDupeImages::Finder.class_variable_get(:path)).to be_truthy
    expect(FindDupeImages::Finder.respond_to?(:traversed_directories)).to be_truthy
  end
end
