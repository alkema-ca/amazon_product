require 'rails_helper'

RSpec.describe Products::Create do
  subject { described_class.new(asin: asin, product_parser: product_parser) }

  let(:call) { subject.call }

  let(:body) { IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html")) }

  let(:product_parser) { Amazon::ProductParser.new(body) }

  context 'B002QYW8LW' do
    let(:asin) { 'B002QYW8LW' }

    it 'creates a Product' do
      expect { call }.to change { Product.count }.from(0).to(1)
    end
  end

  context 'B077JZ4N7D' do
    let(:asin) { 'B077JZ4N7D' }

    it 'creates a Product' do
      expect { call }.to change { Product.count }.from(0).to(1)
    end
  end

end
