class PagesController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end
  def privacy_agreement
  end
end
