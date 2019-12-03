class Admin::PortfoliosController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @portfolios = Portfolio.all.reverse
  end
  def new
    @portfolio = Portfolio.new
  end
  def create
    @portfolio = Portfolio.new(portfolio_params)
    if @portfolio.save
      redirect_to "#{admin_portfolios_path}#message=Демонстрационная работа создана"
    else
      render :new
    end
  end
  def edit
    @portfolio = Portfolio.find(params[:id])
  end
  def update
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.update_attributes(portfolio_params)
      redirect_to "#{admin_portfolios_path}#message=Портфолио обновленно"
    else
      render :edit
    end
  end
  def destroy
    @porfolio = Portfolio.find(params[:id])
    if @porfolio.destroy
      redirect_to "#{admin_portfolios_path}#message=Демонстрационная работа \"#{@porfolio.name}\" удалена"
    else
      render :index
    end
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:picture, :name, :description)
  end
end
