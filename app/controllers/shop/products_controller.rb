class Shop::ProductsController < ApplicationController
  def index
    # категория и продукты имеют связь "один ко многим"
    @category = Category.find(params[:id])
    @products = @category.products.where(available: true).paginate(page: params[:page], per_page: 8)

    @title = @category.name
    @description = @category.description
    @keywords = @category.keywords
  end

  def show
    @product = Product.find(params[:id])
    @title = @product.name
    @description = @product.description
    @keywords = @product.keywords
  end

end
