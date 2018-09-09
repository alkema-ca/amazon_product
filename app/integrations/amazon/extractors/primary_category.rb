module Amazon

  module Extractors

    # Extract the primary ranking from a DOM node's text content, full of whitespace
    class PrimaryCategory

      CATEGORY_EXPRESSION = /#(?<rank>\S+)\s+in\s+(?<name>.+)\s\(.+\)/

      def initialize(text)
        @text = text
        @match = primary_category_text.match(CATEGORY_EXPRESSION)
      end

      def primary_category_text
        @text.split(/\r?\n/).reject { |c| c.strip.empty? }.first
      end

      def data
        Amazon::Data::Category.new(attributes)
      end

      def attributes
        atts = MatchHash.call(@match)
        atts[:rank] = atts[:rank].split(/,/).first
        atts
      end

    end

  end

end
