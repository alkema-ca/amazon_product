module Products

  # Service class to encapsulate fetch Amazon product pages
  class Fetcher

    extend Callable

    def initialize(asin)
      @asin = asin
    end

    def call
      return PageRequest.new(asin: nil, status: nil, body: nil) if @asin.blank?

      response = fetch

      PageRequest.create!(asin: @asin, status: response.status, body: response.body)
    end

    private

    def fetch
      client = Amazon::Connection::Client.new
      client.get("/dp/#{@asin}")
    end

  end

end
