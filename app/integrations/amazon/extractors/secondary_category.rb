module Amazon

  module Extractors

    # Extract secondary category
    class SecondaryCategory

      def initialize(secondary_category_node)
        @secondary_category_node = secondary_category_node
        @ladder_text = @secondary_category_node[:ladder].text
        @rank_text = @secondary_category_node[:rank].text

        @category_names = category_names
      end

      def data
        rank_outer_right
        @category_names
      end

      # '#4 ' => '4'
      def extract_rank
        @rank_text.match(/#(\d+)/)[1]
      end

      def split_ladder
        @ladder_text.split(/>/)
      end

      def category_names
        split_ladder.map do |name|
          name.strip!
          name.sub!(/^in[[:space:]]*/, '')
          Amazon::Data::Category.new(name: name)
        end
      end

      def rank_outer_right
        @category_names.last.rank = extract_rank
      end

    end

  end

end
