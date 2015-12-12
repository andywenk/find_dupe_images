require 'spec_helper'

describe FindDupeImages::Finder do

  subject { FindDupeImages::Finder }

  it 'is described class' do
    expect(described_class).to eql(subject)
  end

  it 'has methods' do
    expect(subject.respond_to?(:run)).to be_truthy
  end

  describe 'has instance variables and' do
    before :each do
      allow(FindDupeImages::Option).to receive(:directory_path).and_return('/path')
      allow(subject).to receive(:result).and_return('')
      allow(subject).to receive(:traverse_directory).and_return('')
      subject.run
    end

    it 'creates a traversed_directories array' do
      expect(subject.instance_variable_get(:@traversed_directories)).to be_a(Array)
    end

    it 'creates a directory_path variable' do
      expect(subject.instance_variable_get(:@directory_path)).to eql('/path')
    end

    it 'creates a directory variable' do
      expect(subject.instance_variable_get(:@directory)).to be_a(Array)
    end
  end

  describe 'has a result' do
    context 'without images' do
      before :each do
        dir = File.dirname(__FILE__) + "/../support/images/without_images"
        allow(FindDupeImages::Option).to receive(:directory_path).and_return(dir)
      end

      it 'with text' do
        expect {subject.run}.to output(/No files have been detectad as duplicates/).to_stdout
      end
    end

    context 'with images but no duplicates' do
      before :each do
        dir = File.dirname(__FILE__) + "/../support/images/without_duplicates"
        allow(FindDupeImages::Option).to receive(:directory_path).and_return(dir)
      end

      it 'with text' do
        expect {subject.run}.to output(/No files have been detectad as duplicates/).to_stdout
      end
    end

    context 'with images and duplicates' do
      before :each do
        dir = File.dirname(__FILE__) + "/../support/images/with_duplicates"
        allow(FindDupeImages::Option).to receive(:directory_path).and_return(dir)
      end

      it 'with text' do
        expect {subject.run}.to output(/The following files have been detected as duplicates/).to_stdout
      end
    end
  end
end
