# An Amazon product
class Product < ApplicationRecord

  has_many :categories, dependent: :destroy
  has_one :page_request, dependent: :destroy

  def grouped_category_sets
    categories.order('id asc, set_id asc').group_by(&:set_id)
  end

end
