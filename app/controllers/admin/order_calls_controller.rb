class Admin::OrderCallsController < ApplicationController
  layout 'admin'

  def index
    order_calls = OrderCall.where(completed: false)
    @order_calls_new = order_calls.select { |order_call| !order_call.saved }
    @order_calls_saved = order_calls.select { |order_call| order_call.saved }
  end

  def edit
    @order_call = OrderCall.find(params[:id])
  end

  def update
    @order_call = OrderCall.find(params[:id])
    path = @order_call.completed ? admin_order_calls_arhive_path : admin_order_calls_path
    if @order_call.update_columns(notes: params[:order_call][:notes])
      redirect_to "#{path}#message=Заявка обновлена"
    else
      render :edit
    end
  end

  def complete
    @order_call = OrderCall.find(params[:id])
    if @order_call.update_columns(completed: true, saved: false)
      @order_call.product.update_columns(available: false)
      redirect_to "#{admin_order_calls_path}#message=Заявка обработана"
    else
      redirect_to "#{admin_order_calls_path}#message=Произошла неведомая херня"
    end
  end

  def save
    @order_call = OrderCall.find(params[:id])
    path = @order_call.completed ? admin_order_calls_arhive_path : admin_order_calls_path
    if @order_call.update_columns(saved: @order_call.saved ? false : true, completed: false)
      redirect_to "#{path}#message=Заявка сохранена"
    else
      redirect_to "#{path}#message=Произошла неведомая херня"
    end
  end

  def arhive
    @order_calls = OrderCall.where(completed: true)
  end

  def destroy
    @order_call = OrderCall.find(params[:id])
    path = @order_call.completed ? admin_order_calls_arhive_path : admin_order_calls_path
    if @order_call.destroy
      redirect_to "#{path}#message=Заявка удалена"
    else
      render :index
    end
  end

  def toogle_available
    @product = Product.find(params[:id])
    unless @product.update_columns(available: params[:available])
      render status: 404
    end
  end
end
