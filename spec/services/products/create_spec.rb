require 'rails_helper'

RSpec.describe Products::Create do
  subject { described_class.new(product_parser) }

  let(:body) { IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html")) }
  let(:page_request) do
    PageRequest.new(asin: asin, status: 200, body: body)
  end

  let(:product_parser) { Amazon::ProductParser.new(page_request) }
  let(:product) { Product.last }

  context 'B002QYW8LW' do
    let(:asin) { 'B002QYW8LW' }

    it 'creates a product' do
      expect { subject.call }.to change { Product.count }.from(0).to(1)
    end

    it 'creates a product with dimensions' do
      subject.call
      expect(product).to have_attributes(
        length: 4.3, width: 0.4, height: 7.9, dimensions_units: 'inches'
      )
    end

    it 'assigns a product to page request' do
      subject.call
      expect(product.page_request).to be_a(PageRequest)
    end

    it 'assigns categories to product' do
      subject.call
      expect(product.categories.count).to eq(8)
      expect(product.categories).to all(be_a(Category))
    end

    it 'assigns categories with `set_id`' do
      subject.call
      expect(product.categories).to all(have_attributes(set_id: be_an(Integer)))
    end

    it 'creates relations within a transaction, except product page' do
      allow_any_instance_of(Product).to receive(:save!).and_raise(ActiveRecord::StaleObjectError)
      expect { subject.call }.to raise_error(ActiveRecord::StaleObjectError)

      expect(Product.count).to eq(0)
      expect(Category.count).to eq(0)
    end

    it 'does not create duplicate categories when resubmitted' do
      subject.call
      expect { subject.call }.not_to change { product.categories.count }.from(8)
    end
  end

  context 'B077JZ4N7D (no primary category)' do
    let(:asin) { 'B077JZ4N7D' }

    it 'creates a product despite missing primary category content' do
      expect { subject.call }.to change { Product.count }.from(0).to(1)
    end
  end
end
