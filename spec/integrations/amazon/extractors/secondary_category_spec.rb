require 'rails_helper'

RSpec.describe Amazon::Extractors::SecondaryCategory do
  subject { described_class.new(ladder_text: ladder_text, rank_text: rank_text) }

  let(:ladder_text) { 'in Baby > Baby Care > Health' }
  let(:rank_text) { '#1' }

  let(:first_category) { subject.data.first }
  let(:last_category) { subject.data.last }

  context 'B002QYW8LW' do
    describe '.data' do
      it 'returns several categories' do
        expect(subject.data.length).to eq(3)
      end

      it "removes 'in ' from first category" do
        expect(first_category.name).to eq('Baby')
      end

      it 'sets the last category with the rank' do
        expect(last_category.rank).to eq(1)
      end
    end
  end
end
