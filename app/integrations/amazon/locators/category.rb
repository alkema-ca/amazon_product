module Amazon

  module Locators

    # Locate the table cell adjacent to the 'Best Sellers Rank' label
    class Category

      def self.call(page)
        page.xpath("//td[@class='label'][text() = 'Best Sellers Rank']/following-sibling::td")
      end

    end

  end

end
