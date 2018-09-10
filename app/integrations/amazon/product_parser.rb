module Amazon

  # Given a product page's body, parse out dimensions, categories and rank into data objects
  class ProductParser

    attr_reader :page_request

    def initialize(page_request)
      @page_request = page_request
      @body = @page_request.body

      @page = Amazon::Page.call(@body)
    end

    def dimensions
      @dimensions ||= Extractors::Dimensions.new(@page).data
    end

    def primary_category
      @primary_category ||= Extractors::PrimaryCategory.new(@page).data
    end

    def secondary_categories
      @secondary_categories ||= Extractors::SecondaryCategories.new(@page).data
    end

  end

end
