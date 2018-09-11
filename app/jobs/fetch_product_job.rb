# Job to fetch products from Amazon
class FetchProductJob < ApplicationJob

  queue_as :urgent

  def perform(asin)
    Products::Fetcher.call(asin)
  end

end
