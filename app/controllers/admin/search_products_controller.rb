class Admin::SearchProductsController < ApplicationController
  layout 'admin'
  include ProtectRoutesConcern
  # before_action :authenticate_user!
  before_action :signed_in?

  def index; end

  def search
    @products = Product.select('name') # потом { name: product['name'], image: url_for(product.thumb_picture), id: product['id'] } 
    render json: @products
  end

  def detected
    @products = Product.where("name LIKE ?", "%#{params[:request]}%")
    render 'detected', locals: { products: @products }, layout: false
  end
end
