class Admin::ContactsController < ApplicationController
  include ProtectRoutesConcern
  layout 'admin'
  before_action :signed_in?

  def index
    @contact_info = Contact.info
  end

  def update
    @contact_info = Contact.info
    @contact_info.update_info(contact_params)
    redirect_to "#{admin_contacts_path}#message=\"Контактная информация обновлена\""
  end

  private

  def contact_params
    params.require(:contacts).permit(:phone, :instagram, :email)
  end
end
