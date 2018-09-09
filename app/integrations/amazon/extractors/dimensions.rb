module Amazon

  module Extractors

    # Extract length, width, height and units dimensions for a product using Regex named captures
    class Dimensions

      # rubocop:disable Metrics/LineLength
      DIMENSIONS_EXPRESSION =
        /(?<length>\d\.?\d?)\sx\s(?<width>\d\.?\d?)\sx\s(?<height>\d\.?\d?)\s(?<dimensions_units>[a-zA-Z]+)/
      # rubocop:enable Metrics/LineLength

      def initialize(text)
        @match = text.match(DIMENSIONS_EXPRESSION)
      end

      def data
        attributes = MatchHash.call(@match)
        Amazon::Data::Dimensions.new(attributes)
      end

    end

  end

end
