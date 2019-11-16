class CartController < ApplicationController
  before_action :get_id, only: [:remove_products, :plus_product, :minus_product]

  def add_product
    @product = Product.find(params[:id])
    create_empty_cart if session[:cart].nil?
    unless session[:cart]['products'][@product.id]
      session[:cart]['products'][@product.id] = { 'count' => 1, 'price' => @product.price }
    else
      session[:cart]['products'][@product.id]['count'] += 1
    end
    session[:cart]['tottal_count'] += 1
    session[:cart]['tottal_price'] += @product.price
    render json: { action: 'add_product', name: @product.name }
  end

  def remove_products
    session[:cart]['tottal_count'] -= session[:cart]['products'][@id]['count']
    session[:cart]['tottal_price'] -= session[:cart]['products'][@id]['price'] * session[:cart]['products'][@id]['count']
    session[:cart]['products'][@id] = nil
    render :json => { tottal_price: session[:cart]['tottal_price'] }
  end

  # подгружаем содержимое корзины
  def show_cart
    products = []
    create_empty_cart if session[:cart].nil?
    session[:cart]['products'].each_with_index do |val, i|
      if val
        product = Product.find(i)
        products << { product: product, count: val['count'] }
      end
    end

    render 'show', locals: { products: products, tottal_price: session[:cart]['tottal_price'] }, :layout => false
  end

  def plus_product
    session[:cart]['products'][@id]['count'] += 1
    session[:cart]['tottal_count'] += 1
    session[:cart]['tottal_price'] += session[:cart]['products'][@id]['price']

    render json: { action: 'plus', count: session[:cart]['products'][@id]['count'], tottal_price: session[:cart]['tottal_price'] }
  end

  def minus_product
    session[:cart]['products'][@id]['count'] -= 1
    session[:cart]['tottal_count'] -= 1
    session[:cart]['tottal_price'] -= session[:cart]['products'][@id]['price']
    session[:cart]['products'][@id] = nil if session[:cart]['products'][@id]['count'] == 0
    render json: { action: 'minus', count: session[:cart]['products'][@id]&.key('count'), tottal_price: session[:cart]['tottal_price'] }
  end

  private

  def create_empty_cart
    session[:cart] = { 'products' => [], 'tottal_count' => 0, 'tottal_price' => 0 }
  end
  def get_id
    @id = params[:id].to_i
  end
end