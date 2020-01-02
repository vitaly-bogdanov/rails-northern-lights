require 'yaml'

class Admin::ContactsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  def index
    @contact = file
  end

  def update
    File.write(file_path, file.update(contact_params).to_yaml)
    flash['contacts_update'] = 'Контактная информация обновлена'
    Rails.cache.delete('contacts')
    Rails.cache.delete('phone_call')
    redirect_to admin_contacts_path
  end

  private
  def contact_params
    params.require(:contacts).permit(:phone, :instagram, :email)
  end
  def file
    YAML.load_file("#{Rails.root}/contacts.yml")
  end
  def file_path
    "#{Rails.root}/contacts.yml"
  end
end
