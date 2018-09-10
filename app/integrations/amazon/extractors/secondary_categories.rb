module Amazon

  module Extractors

    # Extract several categories and one ranking for a given product's 'Best Sellers Rank' row
    class SecondaryCategories

      def initialize(page)
        @category_node = Locators::Category.call(page)
        @secondary_categories_nodes = Locators::SecondaryCategories.call(@category_node)
      end

      def data
        secondary_categories = []
        @secondary_categories_nodes.each do |secondary_category|
          secondary_categories << Extractors::SecondaryCategory.new(secondary_category).data
        end
        secondary_categories
      end

    end

  end

end
