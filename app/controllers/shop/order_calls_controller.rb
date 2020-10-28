class Shop::OrderCallsController < ApplicationController
  def create
    @order_call = OrderCall.new(order_call_params)
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    if @order_call.save
      render json: { controller: 'order_call#create' }, status: :created
    else
      render json: { controller: 'order_call#create', errors: @order_call.errors }, status: 422 #:unprocessable_entity
    end
  end

  private

  def order_call_params
    params.permit(
      :name,
      :telephone,
      :confirm,
      :product_id,
      :timezone,
      :product_name,
      :product_price
    )
  end
end
