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

  def set_will_like_products
    available_products = Rails.cache.fetch('available_products') do 
      Product.where(available: true, unique: false)
    end

    @count_products = available_products.count

    @rand_will_like_product = Rails.cache.fetch('rand_will_like_product') do
      Product.where(available: true, unique: false).limit(4).offset(rand(0..@count_products - 4))
    end
  end

  # def render_404
  #   render file: '', status: 404
  # end

end
