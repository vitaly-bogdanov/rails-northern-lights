class Shop::ProductsController < ApplicationController

  PER_PAGE = 12

  def index
    @category = Category.friendly.find(params[:id])
    @products = @category.products.where(available: true).paginate(page: params[:page], per_page: PER_PAGE)
  end
  
  def show
    @product = Product.friendly.find(params[:id])
  end
end
