require 'rails_helper'

RSpec.describe Amazon::Extractors::PrimaryCategory do
  subject { described_class.new(text) }

  # rubocop:disable Layout/IndentHeredoc
  # Allow text with messy whitespace to replicate actual DOM content
  let(:text) do
    <<~INNERTEXT


    #{primary_category}


        #1
        inBaby > Baby Care > Health


        #2
        inBaby > Baby Care > Pacifiers, Teethers & Teething Relief > Teethers

    INNERTEXT
  end
  # rubocop:enable Layout/IndentHeredoc

  context 'B002QYW8LW' do
    let(:primary_category) { '#6 in Baby (See top 100)' }

    describe '.data' do
      it 'returns the primary category as category data' do
        expect(subject.data).to have_attributes(name: 'Baby', rank: 6)
      end
    end

    describe '.primary_category_text' do
      it 'extracts the primary category text' do
        expect(subject.primary_category_text).to eq('#6 in Baby (See top 100)')
      end
    end
  end

  context 'B01M6CUSV9' do
    let(:primary_category) { '#1,657 in Baby (See top 100)' }

    describe '.data' do
      it 'returns the primary category as category data' do
        expect(subject.data).to have_attributes(name: 'Baby', rank: 1)
      end
    end

    describe '.primary_category_text' do
      it 'extracts the primary category text' do
        expect(subject.primary_category_text).to eq('#1,657 in Baby (See top 100)')
      end
    end
  end
end
