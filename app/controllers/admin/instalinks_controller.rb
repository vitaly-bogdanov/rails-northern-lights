class Admin::InstalinksController < ApplicationController
  layout 'admin'
  include ProtectRoutesConcern
  before_action :signed_in?
  
  def edit
  end

  def update
  end
  
end
