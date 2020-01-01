class Shop::OrderCallsController < ApplicationController
  def create
    @order_call = OrderCall.new(name:          params[:name_order_call], 
                                telephone:     params[:telephone_order_call], 
                                confirm:       params[:confirm_order_call], 
                                product_id:    params[:product_id_order_call], 
                                timezone:      params[:timezone_order_call],
                                product_name:  params[:product_name],
                                product_price: params[:product_price])

    if @order_call.save 
      render :json => {controller: 'order_call#create'}, status: :created 
    else
      render :json => {controller: 'order_call#create', errors: @order_call.errors}, status: 422 #:unprocessable_entity
    end
  end

  private 

  # def order_call_params
  #   params.require(:product).
  # end
end
