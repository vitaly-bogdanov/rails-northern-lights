class ApplicationController < ActionController::Base
  before_action :set_contacts, only: [:index, :privacy_agreement, :new, :show]

  def set_contacts
    contacts = YAML.load_file("#{Rails.root}/contacts.yml")

    @phone      = contacts['phone']
    @phone_call = contacts['phone'].each_char.select { |item| item == '0' or item.to_i != 0 }.join
    @instagram  = contacts['instagram']
    @email      = contacts['email']
  end

  def render_404
    render file: '', status: 404
  end

end
