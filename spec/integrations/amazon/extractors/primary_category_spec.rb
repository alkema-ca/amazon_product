require 'rails_helper'

RSpec.describe Amazon::Extractors::PrimaryCategory do
  subject { described_class.new(page) }

  let(:body) do
    IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html"))
  end

  let(:page) { Amazon::Page.call(body) }

  context 'B002QYW8LW' do
    let(:asin) { 'B002QYW8LW' }

    describe '.data' do
      it 'returns the primary category as category data' do
        expect(subject.data).to have_attributes(name: 'Baby', rank: 6)
      end
    end
  end

  context 'B01M6CUSV9' do
    let(:asin) { 'B01M6CUSV9' }

    describe '.data' do
      it 'returns the primary category as category data' do
        expect(subject.data).to have_attributes(name: 'Baby', rank: 1)
      end
    end
  end

  context 'B01N7QZG8B' do
    let(:asin) { 'B01N7QZG8B' }

    describe '.data' do
      it 'returns the primary category as category data' do
        expect(subject.data).to have_attributes(name: 'Sports & Outdoors', rank: 213)
      end
    end
  end

  # TODO: Handle case where there is no primary category with a better secondary category strategy
  context 'B077JZ4N7D (no primary category)' do
    let(:asin) { 'B077JZ4N7D' }

    describe '.data' do
      it 'returns the primary category as category data' do
        expect(subject.data).to be_nil
      end
    end
  end
end
