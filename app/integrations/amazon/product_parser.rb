module Amazon

  # Given an product page's body, parse out dimensions, categories and rank into data objects
  class ProductParser

    def initialize(body)
      @page = Nokogiri::HTML(body, Encoding::UTF_8.to_s)
      @category_node = Locators::Category.call(@page)
    end

    def dimensions
      dimensions_node = Locators::Dimensions.call(@page)
      Extractors::Dimensions.new(dimensions_node.text).data
    end

    def primary_category
      Extractors::PrimaryCategory.new(@category_node.text).data
    end

    def secondary_categories
      secondary_categories_nodes = Locators::SecondaryCategories.call(@category_node)

      secondary_categories = []
      secondary_categories_nodes.each do |secondary_category|
        secondary_categories << Extractors::SecondaryCategory.new(
          ladder_text: secondary_category[:ladder].text, rank_text: secondary_category[:rank].text
        ).data
      end

      secondary_categories.flatten
    end

  end

end
