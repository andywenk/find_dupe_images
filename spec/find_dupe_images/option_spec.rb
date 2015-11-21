require 'spec_helper'

describe FindDupeImages::Option do
  it 'is described class' do
    expect(described_class).to eql(FindDupeImages::Option)
  end

  it 'has methods' do
    expect(FindDupeImages::Option.respond_to?(:directory_path)).to be_truthy
  end
end
