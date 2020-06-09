class ApplicationController < ActionController::Base
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

  def set_category
    @categories = Rails.cache.fetch('all_categories') do
      Category.all
    end
  end

  def set_last_create_products
    @last_created_products = Rails.cache.fetch('last_create_products') do
      Product.where(available: true, unique: false).order(created_at: :desc).limit(4)
    end
  end
end
