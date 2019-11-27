class Shop::SearchProductsController < ApplicationController
  def index
    @products = Product.where("name LIKE ?", "%#{params[:request]}%").paginate(page: params[:page], per_page: 8)
    @request = params[:request]
  end
  def detected
    @products = Product.where("name LIKE ?", "%#{params[:request]}%").paginate(page: params[:page], per_page: 8)
    @request = params[:request]
    render 'detected', layout: false
  end
  def search
    @products = Product.select('name')
    render :json => @products
  end
end