# Data object to validate ASINs via form data + page request/response data
class PageRequestForm

  include ActiveModel::Model

  include Virtus.model

  attribute :asin, String
  attribute :status, Integer
  attribute :product, Product

  validates :asin, presence: {
    allow_blank: false, message: 'Please enter an ASIN'
  }
  validates :status, inclusion: {
    # rubocop:disable Style/FormatStringToken
    in: 200..299, message: 'Product not available from provided ASIN (status: %{value})'
    # rubocop:enable Style/FormatStringToken
  }
  validates :product, presence: true

end
