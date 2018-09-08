module Amazon

  module Locators

    # Locate the table cell adjacent to the 'Product Dimensions' label
    class Dimensions

      def self.call(page)
        page.xpath("//td[@class='label'][text() = 'Product Dimensions']/following-sibling::td")
      end

    end

  end

end
