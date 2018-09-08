module Amazon

  module Extractors

    # Extract several categories and one ranking for a given product's 'Best Sellers Rank' row
    class SecondaryCategory

      def initialize(ladder_text:, rank_text:)
        @ladder_text = ladder_text
        @rank_text = rank_text

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
