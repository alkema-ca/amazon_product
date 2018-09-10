# Persist a page request
class PageRequest < ApplicationRecord

  belongs_to :product, optional: true

end
