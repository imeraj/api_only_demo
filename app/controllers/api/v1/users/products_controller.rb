class Api::V1::Users::ProductsController < ApplicationController
  before_action :authenticate_with_token

  def index
    user = User.find_by_id(params[:user_id])
    if user
      @page = params[:page].present? ? params[:page] : 1
      @per_page = params[:per_page].present? ? params[:per_page]: 10
      @products = user.products.page(@page).per(@per_page)
      render "products/index", status: :ok
    else
      @message = "User does not exist."
      render "errors/base", status: :unprocessable_entity
    end
  end

end
