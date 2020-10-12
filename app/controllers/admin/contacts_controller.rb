class Admin::ContactsController < ApplicationController
  layout 'admin'
  include ProtectRoutesConcern
  # before_action :authenticate_user!
  before_action :signed_in?

  def index
    @contact_info = Contact.info
  end

  def update
    @contact_info = Contact.info
    @contact_info.update_attributes contact_params
    flash['contacts_update'] = 'Контактная информация обновлена'
    redirect_to admin_contacts_path
  end

  private

  def contact_params
    params.require(:contacts).permit(:phone, :instagram, :email)
  end
end
