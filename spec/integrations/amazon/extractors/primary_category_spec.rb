require 'rails_helper'

RSpec.describe Amazon::Extractors::PrimaryCategory do
  subject { described_class.new(text) }

  # rubocop:disable Layout/IndentHeredoc
  # Allow text with messy whitespace to replicate actual DOM content
  let(:text) do
    <<~INNERTEXT


    #6 in Baby (See top 100)


        #1
        inBaby > Baby Care > Health


        #2
        inBaby > Baby Care > Pacifiers, Teethers & Teething Relief > Teethers

    INNERTEXT
  end
  # rubocop:enable Layout/IndentHeredoc

  context 'B002QYW8LW' do
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
end
