module Amazon

  module Extractors

    # Extract length, width, height and units dimensions for a product using Regex named captures
    class Dimensions

      DIMENSIONS_EXPRESSION =
        /(?<length>\d\.\d)\sx\s(?<width>\d\.\d)\sx\s(?<height>\d\.\d)\s(?<units>[a-zA-Z]+)/

      # "3.5 x 3.2 x 2.5 inches"
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
