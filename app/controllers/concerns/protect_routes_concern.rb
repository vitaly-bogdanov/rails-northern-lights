module ProtectRoutesConcern
  extend ActiveSupport::Concern

  def signed_in?
    unless user_signed_in?
      redirect_to '/403'
    end
  end
end
