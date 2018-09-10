module Products

  # Service class to encapsulate fetch Amazon product pages
  class Fetcher

    def self.call(asin)
      client = Amazon::Connection::Client.new
      response = client.get("/dp/#{asin}")
      body = response.body
      product_parser = Amazon::ProductParser.new(body)
      # product_parser.validate!
      product_parser
    end

  end

end
