class Admin::OrdersController < ApplicationController
  layout "admin" # назначаем шаблон
  before_action :authenticate_user!

  def index
  end

  def show
  end

end
