class InstalinksController < ApplicationController
  before_action :set_contacts

  # GET /instalinks
  def index
    render layout: false
  end
end
