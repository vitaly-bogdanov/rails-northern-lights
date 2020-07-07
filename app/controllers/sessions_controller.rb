class SessionsController < Devise::SessionsController
  layout 'authentication'

  after_action :authenticate_user!

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || admin_calls_path
  end
end
