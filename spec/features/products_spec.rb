require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'product', type: :feature do
  context 'root path' do
    let(:asin) { 'B002QYW8LW' }

    context 'product fetch attempted' do
      before do
        expect(Products::Fetcher).to receive(:call).with(asin).and_return(page_request)
      end

      let(:body) { IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html")) }
      let(:product) { Product.last }
      let(:page_request) { PageRequest.new(asin: asin, status: status, body: body) }

      feature 'create a product' do
        let(:status) { 200 }

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

      feature 'bad ASIN' do
        let(:body) { '401 body' }
        let(:asin) { 'FOO' }
        let(:status) { 401 }

        scenario 'render alert' do
          visit(root_path)
          fill_in 'product_asin', with: asin
          click_button('Fetch Product')
          expect(page).to have_text("Product not available from provided ASIN (status: #{status})")
        end
      end

      feature '500' do
        let(:body) { '500 body' }
        let(:asin) { '😠' }
        let(:status) { 500 }

        scenario 'render alert' do
          visit(root_path)
          fill_in 'product_asin', with: asin
          click_button('Fetch Product')
          expect(page).to have_text("Product not available from provided ASIN (status: #{status})")
        end
      end
    end

    context 'product not fetch attempted' do
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
