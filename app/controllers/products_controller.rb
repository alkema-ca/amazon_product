# Product controller that allows creation of a Product and relations
class ProductsController < ApplicationController

  def index
    @products = Product.all.order('created_at DESC')
    @product = Product.new
  end

  def create
    @asin = product_params[:asin]
    @page_request = Products::Fetcher.call(@asin)

    Products::Create.call(@page_request) if @page_request.status.to_i.between?(200, 299)

    page_request_form

    if @page_request_form.valid?
      flash[:notice] = 'Product fetched from ASIN'
    else
      handle_flashes
    end

    redirect_to root_url
  end

  private

  def product_params
    params.require(:product).permit(:asin)
  end

  def page_request_form
    @page_request_form = PageRequestForm.new(
      asin: @asin,
      status: @page_request.status,
      product: @page_request.product
    )
  end

  def handle_flashes
    errors = @page_request_form.errors
    messages = errors.messages

    flash[:alert] =
      if errors.keys.include?(:asin)
        messages[:asin].first
      elsif errors.keys.include?(:status)
        messages[:status].first
      else
        'Product not created'
      end
  end

end
