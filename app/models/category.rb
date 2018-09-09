# An Amazon category
class Category < ApplicationRecord

  belongs_to :product

  has_one :child, class_name: 'Category', foreign_key: 'parent_id', dependent: :destroy,
                  inverse_of: :parent
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id', optional: true,
                      inverse_of: :child

end
