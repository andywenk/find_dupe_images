require 'spec_helper'

describe FindDupeImages::Option do
  it 'is described class' do
    expect(described_class).to eql(FindDupeImages::Option)
  end

  it 'has methods' do
    expect(FindDupeImages::Option.respond_to?(:path)).to be_truthy
  end
end
