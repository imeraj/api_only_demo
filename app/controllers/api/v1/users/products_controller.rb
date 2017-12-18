class Api::V1::Users::ProductsController < ApplicationController
  before_action :authenticate_with_token

  def index
    user = User.find(params[:user_id])
    unless user.nil?
      @products = user.products
      render "products/index", status: :ok
    else
      @message = "User does not exist."
      render "errors/base", status: :unprocessable_entity
    end
  end

end
