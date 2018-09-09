# A service class to create Product and relations
class Products::Create

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def self.call(asin:, body:)
    # Product.destroy_all

    @product_parser = Amazon::ProductParser.new(body)

    product = Product.find_or_initialize_by(asin: asin)

    ActiveRecord::Base.transaction do
      product.attributes = @product_parser.dimensions.attributes
      product.save!

      product_page = product.build_product_page(body: body)
      product_page.save!

      product.categories.create!(@product_parser.primary_category.attributes.merge(set_id: 0))
    end

    @product_parser.secondary_categories.each_with_index do |category_set, i|
      set_id = i + 1

      category_set.each do |category|
        parent_category = product.categories.where(set_id: set_id).last

        product.categories.create!(
          category.attributes.merge(
            parent_id: parent_category.try(:id),
            set_id: set_id
          )
        )
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

end
