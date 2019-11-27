class Shop::ProductsController < ApplicationController
  def index
    @category = Category.find(params[:id])
    @products = @category.products.where(available: true).paginate(page: params[:page], per_page: 8)
  end
  def show
    @product = Product.find(params[:id])
  end
end
