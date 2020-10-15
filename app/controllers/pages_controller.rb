class PagesController < ApplicationController
  before_action :set_contacts # ApplicationController#set_contacts
  before_action :set_category # ApplicationController#set_category
  before_action :set_last_create_products, only: :index # ApplicationController#set_last_create_products

  # GET /
  def index
    @portfolios = Portfolio.cached_all
  end

  # GET /privacy-agreement
  def privacy_agreement; end

  def instalinks
    render layout: false
  end
end
