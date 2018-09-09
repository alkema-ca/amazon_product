require 'rails_helper'

RSpec.describe Amazon::Extractors::Dimensions do
  subject { described_class.new(text) }

  context 'B002QYW8LW' do
    let(:text) { '4.3 x 0.4 x 7.9 inches' }

    describe '.data' do
      it 'returns secondary_categories as dimensions data' do
        expect(subject.data).to have_attributes(
          length: 4.3, width: 0.4, height: 7.9, dimensions_units: 'inches'
        )
      end
    end
  end

  context 'B00005C5H4' do
    let(:text) { '3.5 x 3.2 x 2.5 inches' }

    describe '.data' do
      it 'returns secondary_categories as category data' do
        expect(subject.data).to have_attributes(
          length: 3.5, width: 3.2, height: 2.5, dimensions_units: 'inches'
        )
      end
    end
  end

  context 'B01M6CUSV9' do
    let(:text) { '4 x 3 x 1 inches' }

    describe '.data' do
      it 'returns secondary_categories as category data' do
        expect(subject.data).to have_attributes(
          length: 4, width: 3, height: 1, dimensions_units: 'inches'
        )
      end
    end
  end
end
