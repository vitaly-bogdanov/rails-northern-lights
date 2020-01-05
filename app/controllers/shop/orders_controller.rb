class Shop::OrdersController < ApplicationController

  before_action :set_contacts, :only => :new
  before_action :set_category, only: [:new, :create]

  def new
    @order = Order.new
    @products = products_from_cart
    @tottal_price = tottal_price_from_cart
  end

  def create
    @order = Order.new initials: params[:order][:initials], 
                      telephone: params[:order][:telephone], 
                         region: params[:order][:region], 
                           city: params[:order][:city], 
                        address: params[:order][:address], 
                       postcode: params[:order][:postcode], 
                        comment: params[:order][:comment], 
                       timezone: params[:order][:timezone], 
                          email: params[:order][:email], 
                        confirm: params[:order][:confirm], 
                   tottal_price: tottal_price_from_cart

    if @order.save
      session[:cart]['products'].each do |product_id, product|
        OrderProduct.create order_id: @order.id, 
                            product_id: product_id.to_i, 
                            count_products: product['count'],
                            products_price: product['count'] * product['price'],
                            unit_price: product['price'],
                            product_name: product['name']
      end
      session.delete(:cart)
      redirect_to "#{root_path}#message=Заказ принят! Мы вам перезвоним в ближайшее время."
    else
      @products = products_from_cart
      @tottal_price = tottal_price_from_cart
      render :new
    end
  end
  
  private

  def products_from_cart
    products = []
    session[:cart]['products'].each do |id, value|
      product = Product.find(id.to_i)
      products << { product: product, count: value['count'] }
    end

    return products
  end

  def tottal_price_from_cart
    session[:cart]['tottal_price']
  end
end
