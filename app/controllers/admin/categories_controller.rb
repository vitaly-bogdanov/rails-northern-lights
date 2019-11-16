class Admin::CategoriesController < ApplicationController
  layout "admin" # назначаем шаблон
  before_action :authenticate_user!

  def index
    @categories = Category.order(created_at: :asc)
  end

  def new 
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to "#{admin_categories_path}?message=Категория \"#{@category.name}\" создана"
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to "#{admin_categories_path}?message=Категория \"#{@category.name}\" обновленна"
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to "#{admin_categories_path}?message=Категория \"#{@category.name}\" удалена"
    else
      render :index
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :description, :keywords)
  end

end
