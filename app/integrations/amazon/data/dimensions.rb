module Amazon

  module Data

    # Data class to hold product dimensions attributes
    class Dimensions

      include Virtus.model

      attribute :length, Decimal
      attribute :width, Decimal
      attribute :height, Decimal

      attribute :dimensions_units, String

    end

  end

end
