require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'product', type: :feature do
  context 'root path' do
    let(:asin) { 'B002QYW8LW' }

    feature 'valid input' do
      before do
        ActiveJob::Base.queue_adapter = :inline
        expect(Products::Fetcher).to receive(:call).with(asin).and_return(product_parser)
      end

      let(:body) { IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html")) }
      let(:page_request) { PageRequest.new(asin: asin, status: 200, body: body) }
      let(:product_parser) { Amazon::ProductParser.new(page_request) }
      let(:product) { Product.last }

      scenario 'render product and notice' do
        visit(root_path)
        fill_in 'product_asin', with: asin
        click_button('Fetch Product')
        expect(page).to have_text(product.asin)
        expect(page).to have_text(product.height)
        expect(page).to have_text(product.categories.first.name)
        expect(page).to have_text('Product fetched from ASIN')
      end
    end

    feature 'invalid input' do
      scenario 'render alert' do
        visit(root_path)
        fill_in 'product_asin', with: ''
        click_button('Fetch Product')
        expect(page).to have_text('Please enter an ASIN')
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
