module Amazon

  module Locators

    # Locate the unordered list within the category node (category table cell)
    class SecondaryCategories

      extend Callable

      def initialize(category_node)
        @category_node = category_node
      end

      def call
        @category_node.xpath("//ul/li[@class='zg_hrsr_item']").map do |li|
          {
            ladder: li.xpath("span[@class='zg_hrsr_ladder']").first,
            rank: li.xpath("span[@class='zg_hrsr_rank']").first
          }
        end
      end

    end

  end

end
