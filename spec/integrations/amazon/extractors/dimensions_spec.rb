require 'rails_helper'

RSpec.describe Amazon::Extractors::Dimensions do
  subject { described_class.new(page) }

  let(:body) do
    IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html"))
  end

  let(:page) { Amazon::Page.call(body) }

  context 'B002QYW8LW' do
    let(:asin) { 'B002QYW8LW' }

    describe '.data' do
      it 'returns secondary_categories as dimensions data' do
        expect(subject.data).to have_attributes(
          length: 4.3, width: 0.4, height: 7.9, dimensions_units: 'inches'
        )
      end
    end
  end

  context 'B00005C5H4' do
    let(:asin) { 'B00005C5H4' }

    describe '.data' do
      it 'returns secondary_categories as category data' do
        expect(subject.data).to have_attributes(
          length: 3.5, width: 3.2, height: 2.5, dimensions_units: 'inches'
        )
      end
    end
  end

  context 'B01M6CUSV9' do
    let(:asin) { 'B01M6CUSV9' }

    describe '.data' do
      it 'returns secondary_categories as category data' do
        expect(subject.data).to have_attributes(
          length: 4, width: 3, height: 1, dimensions_units: 'inches'
        )
      end
    end
  end

  context 'B01N7QZG8B' do
    let(:asin) { 'B01N7QZG8B' }

    describe '.data' do
      it 'returns secondary_categories as category data' do
        expect(subject.data).to be_nil
      end
    end
  end

  context 'B06XGTJDZ5' do
    let(:asin) { 'B06XGTJDZ5' }
    # '16.5 x 9 x 10.4 inches'
    describe '.data' do
      it 'returns secondary_categories as category data' do
        expect(subject.data).to have_attributes(
          length: 16.5, width: 9, height: 10.4, dimensions_units: 'inches'
        )
      end
    end
  end
end
