class PagesController < ApplicationController

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
