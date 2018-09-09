# An Amazon product
class Product < ApplicationRecord

  has_many :categories, dependent: :destroy
  has_one :product_page, dependent: :destroy

end
