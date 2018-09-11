module Products

  # Service class to encapsulate fetch Amazon product pages
  class Fetcher

    extend Callable

    def initialize(asin)
      @asin = asin
    end

    def call
      return build_page_request(status: nil, body: nil) if @asin.blank?

      response = fetch

      build_page_request(status: response.status, body: response.body)
    end

    private

    def build_page_request(status:, body:)
      PageRequest.create!(asin: @asin, status: status, body: body)
    end

    def fetch
      client = Amazon::Connection::Client.new
      client.get("/dp/#{@asin}")
    end

  end

end
