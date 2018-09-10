module Amazon

  module Connection

    # Simple HTTP client for Amazon product fetching
    class Client

      USER_AGENTS = [
        # 'Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0)',
        'Mozilla/5.0 (Windows NT 10.0; rv:54.0) Gecko/20100101 Firefox/53.0',
        'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0'
      ].freeze

      def initialize(endpoint = 'https://www.amazon.com', logger: Logger.new(STDOUT))
        @endpoint = endpoint

        @connection =
          ::Faraday.new(@endpoint, connection_options) do |conn|
            conn.response :logger, logger, bodies: false
            conn.adapter ::Faraday.default_adapter
          end
      end

      delegate(*::Faraday::Connection::METHODS, to: :@connection)

      protected

      def connection_options
        {
          headers: {
            user_agent: USER_AGENTS.sample
          },
          request: {
            timeout: 90
          }
        }
      end

    end

  end

end
