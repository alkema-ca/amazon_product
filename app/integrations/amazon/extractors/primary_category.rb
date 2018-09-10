module Amazon

  module Extractors

    # Extract the primary ranking from a DOM node's text content, full of whitespace
    class PrimaryCategory

      CATEGORY_EXPRESSION = /#(?<rank>\S+)\s+in\s+(?<name>.+)\s\(.+\)/

      def initialize(page)
        @page = page
        @text = node.text
      end

      def data
        return nil unless match

        Amazon::Data::Category.new(attributes)
      end

      def match
        @match ||= @text.match(CATEGORY_EXPRESSION)
      end

      def attributes
        atts = MatchHash.call(match)
        atts[:rank] = atts[:rank].split(/,/).first
        atts
      end

      def node
        category_node = Locators::Category.call(@page)
        @node ||= category_node.any? ? category_node : Locators::Body.call(@page)
      end

    end

  end

end
