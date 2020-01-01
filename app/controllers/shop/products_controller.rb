class Shop::ProductsController < ApplicationController
  before_action :set_contacts
  before_action :set_category
  before_action :set_last_create_products, :only => :show
  PER_PAGE = 12

  # GET /shop/products-category/:id
  def index
    @category = Rails.cache.fetch("index_category_#{params[:id]}") do
      Category.friendly.find(params[:id])
    end
    @products = Rails.cache.fetch("index_products_#{params[:id]}") do
      @category.products.where(available: true).paginate(page: params[:page], per_page: PER_PAGE)
    end
  end
  
  # GET /shop/products/:id
  def show
    @product =  Rails.cache.fetch("show_product_#{params[:id]}") do
      Product.friendly.find(params[:id])
    end
  end
end
