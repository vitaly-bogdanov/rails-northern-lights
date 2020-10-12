class ApplicationController < ActionController::Base
  include Devise::Controllers::Rememberable

  def set_contacts
    # нужно очистить кеш при изменении данных
    @contacts = Contact.info
  end

  def set_category
    # нужно очистить кеш при создании новой категории
    @categories = Category.cached_all
  end

  def set_last_create_products
    # нужно очистить кеш при добавлении нового товара
    @last_created_products = Product.last_create_products_cached
  end
end
