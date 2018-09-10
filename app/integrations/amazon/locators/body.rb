module Amazon

  module Locators

    # Fallback locator, to try the whole page as a last resort
    class Body

      def self.call(page)
        page.xpath('//body')
      end

    end

  end

end
