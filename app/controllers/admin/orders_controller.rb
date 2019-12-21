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
    @tottal_price = @order.tottal_price
    @meta_products = []
    @order.order_products.each do |meta_product|

      if meta_product.product.nil?
        @tottal_price -= meta_product.products_price
      end

      @meta_products << { 
        product: meta_product.product, 
        count: meta_product.count_products,
        products_price: meta_product.products_price,
        unit_price: meta_product.unit_price,
        product_name: meta_product.product_name
      }
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_columns(notes: params[:order][:notes])
      redirect_to "#{admin_orders_path}#message=Заказ обновлен"
    else
      render :edit
    end
  end

  def complete
    @order = Order.find(params[:id])
    if @order.update_columns(completed: true, saved: false)
      redirect_to "#{admin_orders_path}#message=Заказ обработан"
    else
      redirect_to "#{admin_orders_path}#message=Произошла неведомая херня"
    end
  end

  def save
    @order = Order.find(params[:id])
    path = @order.completed ? admin_orders_arhive_path : admin_orders_path
    if @order.update_columns(saved: @order.saved ? false : true, completed: false)
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
