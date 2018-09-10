require 'rails_helper'

RSpec.describe Amazon::Extractors::SecondaryCategory do
  subject { described_class.new(node) }

  let(:body) do
    IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html"))
  end

  let(:page) { Amazon::Page.call(body) }

  let(:node) do
    category_node = Amazon::Locators::Category.call(page)
    Amazon::Locators::SecondaryCategories.call(category_node).first
  end

  let(:first_category) { subject.data.first }
  let(:last_category) { subject.data.last }

  context 'B002QYW8LW' do
    let(:asin) { 'B002QYW8LW' }

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
