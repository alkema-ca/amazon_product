# Product controller that allows creation of a Product and relations
class ProductsController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC')
    @product = Product.new
  end

  def create
    asin = product_params[:asin]

    if asin.blank?
      flash[:alert] = 'Please enter an ASIN'
    else
      flash[:notice] = 'Product fetched from ASIN'
      FetchProductJob.perform_later(asin)
    end

    redirect_to root_url
  end

  private

  def product_params
    params.require(:product).permit(:asin)
  end

end
