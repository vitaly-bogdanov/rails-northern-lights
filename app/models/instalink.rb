class Instalink < ApplicationRecord
  class << self
    def info
      instalinks_info = Rails.cache.fetch('instalinks') { self.first }
      if instalinks_info
        instalinks_info
      else
        self.cache_clear
        self.create
      end
    end
    def cache_clear
      Rails.cache.delete('instalinks')
    end
  end
  def update_info(params)
    self.update_attributes(params)
    self.class.cache_clear
  end
end
