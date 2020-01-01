class PagesController < ApplicationController
  before_action :set_contacts
  before_action :set_category
  before_action :set_will_like_products, :only => :index

  # GET /
  def index
    @portfolios = Rails.cache.fetch('pages_partfolio') do
      Portfolio.all
    end
  end

  # GET /privacy-agreement
  def privacy_agreement
  end
end
