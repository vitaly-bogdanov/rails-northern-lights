class ErrorsController < ApplicationController
  before_action :set_contacts
  before_action :set_category

  # GET /404
  def not_found
    render '404', layout: 'application', status: 404
  end

  # GET /422
  def unacceptable
    render '422', layout: 'application', status: 422
  end

  # GET /500
  def internal_server_error
    render '500', layout: 'application', status: 500
  end

end
