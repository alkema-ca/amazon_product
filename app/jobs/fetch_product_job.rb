# Job to fetch products from Amazon
class FetchProductJob < ApplicationJob

  queue_as :urgent

  def perform(asin)
    product_parser = Products::Fetcher.call(asin)
    Products::Create.call(asin: asin, product_parser: product_parser)
  end

end
