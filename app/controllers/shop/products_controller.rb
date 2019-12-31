class Shop::ProductsController < ApplicationController

  PER_PAGE = 12

  def index
    @category = Rails.cache.fetch("index_category_#{params[:id]}") do
      Category.friendly.find(params[:id])
    end
    @products = Rails.cache.fetch("index_products_#{params[:id]}") do
      @category.products.where(available: true).paginate(page: params[:page], per_page: PER_PAGE)
    end
  end
  
  def show
    @product =  Rails.cache.fetch('show_product') do
      Product.friendly.find(params[:id])
    end
  end
end
