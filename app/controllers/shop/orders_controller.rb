require 'digest/md5'

class Shop::OrdersController < ApplicationController
  def new
    @order = Order.new

    @products = products_from_cart
    @tottal_price = tottal_price_from_cart
    # render 'new', locals: { products: products, tottal_price: session[:cart]['tottal_price'] }
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      session[:cart]['products'].each do |product_id, product|
        OrderProduct.create order_id: @order.id, 
                            product_id: product_id.to_i, 
                            count_products: product['count']
      end

      # redirect_to
      
    else
      @products = products_from_cart
      @tottal_price = tottal_price_from_cart
      
      render :new
    end
    # @order_product = OrderProduct.create()

    # render html: session[:cart]
  end
  
  private

  def order_params
    params
      .require(:order)
        .permit :initials, 
                :telephone, 
                :region, 
                :city, 
                :address,
                :postcode, 
                :comment,
                :timezone,
                :email,
                :confirm
  end

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

# t.string  :initials
# t.string  :telephone
# t.string  :region
# t.string  :city
# t.string  :address
# t.integer :postcode
# t.string  :comment
# t.string  :timezone
# t.string  :email,     default: nil
# t.text    :notes
# t.boolean :completed, default: false
# t.boolean :saved,     default: false
# t.boolean :paid,      default: false

# mrh_login = "demo"
# mrh_pass1 = "password_1"
# inv_id = 0
# inv_desc = "ROBOKASSA Advanced User Guide"
# out_summ = "8.96"
# shp_item = 1
# in_curr = ""
# culture = "ru"
# encoding = "utf-8"
# crc = Digest::MD5.hexdigest("#{mrh_login}:#{out_summ}:#{inv_id}:#{mrh_pass1}:Shp_item=#{shp_item}")

# @pay_link = "https://auth.robokassa.ru/Merchant/PaymentForm/FormFLS.js?" +
# "MrchLogin=#{mrh_login}&OutSum=#{out_summ}&InvId=#{inv_id}&IncCurrLabel=#{in_curr}" +
# "&Desc=#{inv_desc}&SignatureValue=#{crc}&Shp_item=#{shp_item}" +
# "&Culture=#{culture}&Encoding=#{encoding}"

# $mrh_login = "demo";
# $mrh_pass1 = "password_1";

# // номер заказа
# // number of order
# $inv_id = 0;

# // описание заказа
# // order description
# $inv_desc = "ROBOKASSA Advanced User Guide";

# // сумма заказа
# // sum of order
# $out_summ = "8.96";

# // тип товара
# // code of goods
# $shp_item = 1;

# // предлагаемая валюта платежа
# // default payment e-currency
# $in_curr = "";

# // язык
# // language
# $culture = "ru";

# // кодировка
# // encoding
# $encoding = "utf-8";

# // формирование подписи
# // generate signature
# $crc  = md5("$mrh_login:$out_summ:$inv_id:$mrh_pass1:Shp_item=$shp_item");

# // HTML-страница с кассой
# // ROBOKASSA HTML-page
# print "<html><script language=JavaScript ".
#       "src='https://auth.robokassa.ru/Merchant/PaymentForm/FormFLS.js?".
#       "MrchLogin=$mrh_login&OutSum=$out_summ&InvId=$inv_id&IncCurrLabel=$in_curr".
#       "&Desc=$inv_desc&SignatureValue=$crc&Shp_item=$shp_item".
#       "&Culture=$culture&Encoding=$encoding'></script></html>";
