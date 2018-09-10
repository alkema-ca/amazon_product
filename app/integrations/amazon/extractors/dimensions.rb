module Amazon

  module Extractors

    # Extract length, width, height and units dimensions for a product using Regex named captures
    class Dimensions

      # rubocop:disable Metrics/LineLength
      DIMENSIONS_EXPRESSION =
        /(?<length>\d*\.?\d*)\sx\s(?<width>\d*\.?\d*)\sx\s(?<height>\d*\.?\d*)\s*\s(?<dimensions_units>[a-zA-Z]*)/
      # rubocop:enable Metrics/LineLength

      def initialize(page)
        @page = page
        @text = node.text
      end

      def data
        @match = @text.match(DIMENSIONS_EXPRESSION)
        return nil unless @match

        attributes = MatchHash.call(@match)
        Amazon::Data::Dimensions.new(attributes)
      end

      def node
        dimensions_node = Locators::Dimensions.call(@page)
        @node ||= dimensions_node.any? ? dimensions_node : Locators::Body.call(@page)
      end

    end

  end

end
