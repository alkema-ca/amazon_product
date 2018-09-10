# Products Helper
module ProductsHelper

  def dimensions(product)
    return 'Dimensions not available' unless product.length && product.width && product.height
    "#{product.length} x #{product.width} x #{product.height} #{product.dimensions_units}"
  end

end
