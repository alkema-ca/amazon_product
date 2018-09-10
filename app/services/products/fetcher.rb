module Products

  # Service class to encapsulate fetch Amazon product pages
  class Fetcher

    def self.call(asin)
      client = Amazon::Connection::Client.new
      response = client.get("/dp/#{asin}")
      body = response.body

      page_request = PageRequest.create!(asin: asin, status: response.status, body: body)
      Amazon::ProductParser.new(page_request)
    end

  end

end
