class Contact < ApplicationRecord
  class << self
    def info
      constact_info = self.first
      if constact_info
        constact_info
      else
        self.create
      end
    end
  end
  def call_format_phone
    Rails.cache.fetch('phone_call') do
      self.phone.each_char.select { |item| item == '0' or item.to_i != 0 }.join
    end
  end
end
