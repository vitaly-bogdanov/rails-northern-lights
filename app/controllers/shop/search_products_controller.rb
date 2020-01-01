class Shop::SearchProductsController < ApplicationController
  before_action :set_contacts, only: :index
  before_action :set_category, only: :index

  def index
    @products = Product.where("name LIKE ?", "%#{params[:request]}%")
    @request = params[:request]
  end

  def detected
    @products = Product.where("name LIKE ?", "%#{params[:request]}%")
    @request = params[:request]
    render 'detected', layout: false
  end

  def search
    @products = Product.select('name')
    render :json => @products
  end
end