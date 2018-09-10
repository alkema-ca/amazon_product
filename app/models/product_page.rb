# Persist an Amazon product page for an ASIN
class ProductPage < ApplicationRecord

  belongs_to :product, optional: true

end
