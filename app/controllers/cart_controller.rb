class CartController < ApplicationController
  before_action :get_id, only: [:remove_products, :plus_product, :minus_product]

  def add_product
    @product = Product.find(params[:id])
    create_empty_cart if session[:cart].nil?
    unless session[:cart]['products'][@product.id.to_s]
      session[:cart]['products'][@product.id.to_s] = { 'count' => 1, 'price' => @product.price }
    else
      session[:cart]['products'][@product.id.to_s]['count'] += 1
    end
    session[:cart]['tottal_count'] += 1
    session[:cart]['tottal_price'] += @product.price
    render json: { action: 'add_product', name: @product.name }
  end

  # подгружаем содержимое корзины
  def show_cart
    products = []
    create_empty_cart if session[:cart].nil?
    session[:cart]['products'].each do |i, v|
      if v
        product = Product.find(i.to_i)
        products << { product: product, count: v['count'] }
      end
    end
    render 'show', locals: { products: products, tottal_price: session[:cart]['tottal_price'] }, :layout => false
  end

  # cart/:id/remove-products 
  # remove_products_path(product)
  def remove_products
    session[:cart]['tottal_count'] -= session[:cart]['products'][@id]['count']
    session[:cart]['tottal_price'] -= session[:cart]['products'][@id]['price'] * session[:cart]['products'][@id]['count']
    session[:cart]['products'].delete(@id)
    render :json => { tottal_price: session[:cart]['tottal_price'] }
  end

  # cart/:id/plus-product
  # plus_product_path(product)
  def plus_product
    session[:cart]['products'][@id]['count'] += 1
    session[:cart]['tottal_count']           += 1
    session[:cart]['tottal_price']           += session[:cart]['products'][@id]['price']
    render json: { 
      count:        session[:cart]['products'][@id]['count'], 
      tottal_price: session[:cart]['tottal_price'] 
    }
  end

  # cart/:id/minus-product
  # minus_product_path(product)
  def minus_product
    session[:cart]['products'][@id]['count'] -= 1
    session[:cart]['tottal_count']           -= 1
    session[:cart]['tottal_price']           -= session[:cart]['products'][@id]['price']
    if session[:cart]['products'][@id]['count'] == 0
      session[:cart]['products'].delete(@id)
      count = 0
    else
      count = session[:cart]['products'][@id]['count']
    end
    render json: { count: count, tottal_price: session[:cart]['tottal_price'] }
  end

  private

  def create_empty_cart
    session[:cart] = { 'products' => {}, 'tottal_count' => 0, 'tottal_price' => 0 }
  end

  def get_id
    @id = params[:id]
  end
end