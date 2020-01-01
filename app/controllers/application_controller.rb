class ApplicationController < ActionController::Base
  before_action :set_contacts, only: [:index, :privacy_agreement, :new, :show]
  include Devise::Controllers::Rememberable

  def set_contacts
    contacts = Rails.cache.fetch('contacts') do
      YAML.load_file("#{Rails.root}/contacts.yml")
    end
    
    @phone = contacts['phone']
    @phone_call = Rails.cache.fetch('phone_call') do 
      contacts['phone'].each_char.select { |item| item == '0' or item.to_i != 0 }.join
    end
    @instagram = contacts['instagram']
    @email = contacts['email']
  end

  # def render_404
  #   render file: '', status: 404
  # end

end
