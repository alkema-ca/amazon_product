# Product controller that allows creation of a Product and relations
class ProductsController < ApplicationController

  def index
    @products = Product.all
    @product = Product.new
  end

  def create
    asin = product_params[:asin]

    client = Amazon::Connection::Client.new
    response = client.get("/dp/#{asin}")
    body = response.body

    # body = IO.read(Rails.root.join('spec', 'fixtures', "#{asin}.html"))

    Products::Create.call(asin: asin, body: body)

    redirect_to root_url
  end

  private

  def product_params
    params.require(:product).permit(:asin)
  end

end
