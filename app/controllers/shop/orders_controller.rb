require 'digest/md5'

class Shop::OrdersController < ApplicationController
  def new
    mrh_login = "demo"
    mrh_pass1 = "password_1"
    inv_id = 0
    inv_desc = "ROBOKASSA Advanced User Guide"
    out_summ = "8.96"
    shp_item = 1
    in_curr = ""
    culture = "ru"
    encoding = "utf-8"
    crc = Digest::MD5.hexdigest("#{mrh_login}:#{out_summ}:#{inv_id}:#{mrh_pass1}:Shp_item=#{shp_item}")

    @pay_link = "https://auth.robokassa.ru/Merchant/PaymentForm/FormFLS.js?" +
    "MrchLogin=#{mrh_login}&OutSum=#{out_summ}&InvId=#{inv_id}&IncCurrLabel=#{in_curr}" +
    "&Desc=#{inv_desc}&SignatureValue=#{crc}&Shp_item=#{shp_item}" +
    "&Culture=#{culture}&Encoding=#{encoding}"
  end

  def create
  end
end


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
