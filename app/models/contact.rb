class Contact < ApplicationRecord
  class << self
    def info
      constact_info = Rails.cache.fetch('contacts') { self.first }
      if constact_info
        constact_info
      else
        self.cache_clear
        self.create
      end
    end
    def cache_clear
      Rails.cache.delete('contacts')
      Rails.cache.delete('phone_call')
    end
  end
  def call_format_phone
    Rails.cache.fetch('phone_call') do
      self.phone.each_char.select { |item| item == '0' or item.to_i != 0 }.join
    end
  end
  def update_info params
    self.update_attributes params # обновляем контакты
    self.class.cache_clear # чистим кеш
  end
end
