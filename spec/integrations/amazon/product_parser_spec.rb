require 'rails_helper'

RSpec.describe Amazon::ProductParser do
  subject { described_class.new(body) }

  let(:body) do
    IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html"))
  end

  let(:asin) { 'B002QYW8LW' }

  describe '.dimensions' do
    it 'returns dimensions as data' do
      expect(subject.dimensions).to be_kind_of(Amazon::Data::Dimensions)
    end
  end

  describe '.primary_category' do
    it 'returns primary_category as data' do
      expect(subject.primary_category).to have_attributes(name: 'Baby', rank: 6)
    end
  end

  describe '.secondary_categories' do
    it 'returns secondary_categories as category data' do
      expect(subject.secondary_categories).to all(be_kind_of(Amazon::Data::Category))

      expect(subject.secondary_categories).to all(
        have_attributes(
          name: a_kind_of(String), rank: a_kind_of(Integer)
        ).or(have_attributes(rank: nil))
      )
    end
  end
end
