class Admin::OrdersController < ApplicationController
  layout "admin" # назначаем шаблон
  before_action :authenticate_user!

  def index
    orders = Order.where(completed: false)

    @orders_new = orders.select { |order| !order.saved }
    @orders_saved = orders.select { |order| order.saved }
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_columns(notes: params[:notes])
      redirect_to "#{admin_orders_path}#message=Заказ обновлен"
    else
      render :edit
    end
  end

  def complete
    @order = Order.find(params[:id])
    if @order.update_columns(completed: true, saved: false)
      redirect_to "#{admin_orders_path}#message=Заказ обработана"
    else
      redirect_to "#{admin_orders_path}#message=Произошла неведомая херня"
    end
  end

  def save
    @order = Order.find(params[:id])
    path = @order.completed ? admin_order_calls_arhive_path : admin_orders_path
    if @order_call.update_columns(saved: @order.saved ? false : true, completed: false)
      redirect_to "#{path}#message=Заказ сохранен"
    else
      redirect_to "#{path}#message=Произошла неведомая херня"
    end
  end

  def arhive
    @order = Order.where(completed: true)
  end

  def destroy
    @order = Order.find(params[:id])
    path = @order.completed ? admin_orders_arhive_path : admin_orders_path
    if @order.destroy
      redirect_to "#{path}#message=Заказ удален"
    else
      render :index
    end
  end

end
