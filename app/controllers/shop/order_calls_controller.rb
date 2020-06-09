class Shop::OrderCallsController < ApplicationController
  def create
    @order_call = OrderCall.new(order_call_params)
    if @order_call.save
      render json: { controller: 'order_call#create' }, status: :created
    else
      render json: { controller: 'order_call#create', errors: @order_call.errors }, status: 422 #:unprocessable_entity
    end
  end

  private

  def order_call_params
    params.permit(
      :name_order_call,
      :telephone_order_call,
      :confirm_order_call,
      :product_id_order_call,
      :timezone_order_call,
      :product_name,
      :product_price
    )
  end
end
