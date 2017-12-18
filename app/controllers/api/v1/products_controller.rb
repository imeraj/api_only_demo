class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_with_token

  def index
    @products = Product.where(published: true)
    render "products/index", status: :ok
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      render "products/show", status: :created, location: products_path(@user)
    else
      render "models/product_errors", status: :unprocessable_entity
    end
  end

  def update
    @product = current_user.products.find_by_id(params[:id])
    if @product and @product.update(product_params)
      render "products/show", status: :ok
    else
      @message = "Wrong number/format of parameters."
      render "errors/base", status: :unprocessable_entity
    end
  end

  def destroy
    products = current_user.products.where("id IN (?)", params[:id].split(','))
    unless products.empty?
      products.update_all(published: false)
      head :no_content
    else
      @message = "Wrong number/format of parameters."
      render "errors/base", status: :unprocessable_entity
    end
  end

  private
  def product_params
    params.require("product").permit(:title, :price, :published)
  end

end
