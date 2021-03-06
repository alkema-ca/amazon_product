# A service class to create Product and relations
class Products::Create

  extend Callable

  def initialize(page_request)
    @page_request = page_request

    @product_parser = Amazon::ProductParser.new(@page_request)

    @asin = @page_request.asin
    @body = @page_request.body

    @product = Product.find_or_initialize_by(asin: @asin)
  end

  def call
    ActiveRecord::Base.transaction do
      @product.categories.destroy_all if @product.persisted?

      @product.attributes = @product_parser.dimensions.attributes if @product_parser.dimensions
      @product.save!

      assign_page_request!
      create_categories
    end
  end

  private

  def create_categories
    create_primary_category
    create_secondary_categories
  end

  def assign_page_request!
    @page_request.update!(product: @product)
  end

  def create_primary_category
    return unless @product_parser.primary_category
    @product.categories.create!(@product_parser.primary_category.attributes.merge(set_id: 0))
  end

  def create_secondary_categories
    @product_parser.secondary_categories.each_with_index do |category_set, i|
      set_id = i + 1

      category_set.each do |category|
        parent_category = @product.categories.where(set_id: set_id).last

        @product.categories.create!(
          category.attributes.merge(parent_id: parent_category.try(:id), set_id: set_id)
        )
      end
    end
  end

end
