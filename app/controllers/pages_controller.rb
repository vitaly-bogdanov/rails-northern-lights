class PagesController < ApplicationController
  before_action :set_contacts
  before_action :set_category
  before_action :set_last_create_products, only: :index

  # GET /
  def index
    @portfolios = Portfolio.cached_all
  end

  # GET /privacy-agreement
  def privacy_agreement; end
end
