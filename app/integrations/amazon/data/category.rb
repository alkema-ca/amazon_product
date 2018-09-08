module Amazon

  module Data

    # Data class to hold product categories attributes, a rank may be nil
    class Category

      include Virtus.model

      attribute :name, String
      attribute :rank, Integer

    end

  end

end
