# Product controller that allows creation of a Product and relations
class ProductsController < ApplicationController

  def index
    @products = Product.all
    @product = Product.new
  end

  def create
    asin = product_params[:asin]

    product_parser = Products::Fetcher.call(asin)
    Products::Create.call(asin: asin, product_parser: product_parser)

    redirect_to root_url
  end

  private

  def product_params
    params.require(:product).permit(:asin)
  end

end
