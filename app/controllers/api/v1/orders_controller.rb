class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_with_token

  def create
    valid_ids_assoc = Product.select(:id).where("published IN (?) AND id IN (?)",
                                            true, params[:order][:product_ids])
    @order = current_user.orders.build(:product_ids => valid_ids_assoc.ids)
    if @order.save
      OrderMailer.send_confirmation(@order).deliver_later
      render "orders/show", status: :ok, location: orders_path(@order)
    else
      render "models/order_errors", status: :unprocessable_entity
    end
  end

  def show
    @order = current_user.orders.find_by_id(params[:id])
    if @order
      # ETag caching: Consumer must send If-None-Match (Etag)
      # or If-Modified-Since (Last Modified)
      if stale?(strong_etag: @order, last_modified: @order.created_at, public: true)
        render "orders/show", status: :ok
      else
        head :not_modified
      end
    else
      @message = "Order not found for current user."
      render "errors/base", status: :not_found
    end
  end

private
  def order_params
    params.require(:order).permit(:product_ids => [])
  end

end
