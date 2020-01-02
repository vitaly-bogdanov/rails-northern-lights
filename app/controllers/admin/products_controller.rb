class Admin::ProductsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  # страница со всем товарами
  def index
    @products = Product.order(created_at: :asc)
  end

  # страницы товаров каждой категории
  def category_products
    @category = Category.find(params[:id])
    @products = Product.where(category_id: params[:id]).select('id, picture, name, slug').order(created_at: :asc)
  end

  def new
    @categories = Category.select("id, name")
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to "#{admin_category_products_path(@product.category.id)}#message=Товар \"#{@product.name}\" создан"
    else
      @categories = Category.select("id, name") # на странице создания товаров нужен перечень категорий
      render :new
    end
  end

  def edit
    @categories = Category.select("id, name")
    @product = Product.friendly.find(params[:id])
  end

  def update
    @product = Product.friendly.find(params[:id])
    if @product.update_attributes(product_params)
      Rails.cache.delete("show_product_#{params[:id]}")
      # на случай если товар был ранее еденичным проданным, а потом стал нееденичным
      @product.update_attributes(available: true) unless @product.available
      redirect_to "#{admin_category_products_path(@product.category.id)}#message=Информация о товаре обновленно"
    else
      @categories = Category.select("id, name") # на странице редактирования товаров нужен перечень категорий
      render :edit
    end
  end

  def destroy
    @product = Product.friendly.find(params[:id])
    path = admin_products_path                                if params[:from_place] == 'all_products'
    path = admin_category_products_path(@product.category.id) if params[:from_place] == 'category_products'
    path = nil                                                if params[:from_place] == 'search'
    if @product.destroy
      Rails.cache.delete("show_product_#{params[:id]}")
      redirect_to "#{path}#message=Товар \"#{@product.name}\" удален" unless path.nil? 
    else
      render :index
    end
  end

  private

  def product_params
    params.require(:product).permit :picture, :category_id, :name, :price, :description, :preview, :keywords, :unique
  end
end
