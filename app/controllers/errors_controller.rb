class ErrorsController < ApplicationController

  def not_found
    render '404', layout: 'application', status: 404
  end

  def unacceptable
    render status: 422
  end

  def internal_server_error
    render status: 500
  end

end
