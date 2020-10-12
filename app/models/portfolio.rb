=begin
  "Портфолио"
  
  Модель отвечает за демонстрационные 
  работы на главной странице в слайдере.
  Имеет три поля: picture, name, description.
=end
class Portfolio < ApplicationRecord
  # связь с картинкой, удаление картинки при удалении записи
  has_one_attached :picture, dependent: :purge_later
  # валидация названия записи в портфолио
  validates :name, presence: { message: 'Название проекта обязательно' } 
  # валидация описания записи в портфолио
  validates :description, presence: { message: 'Описание проекта обязательно' }
  validate :validate_picture # метод находится в ApplicationRecord

  class << self
    def cached_all
      Rails.cache.fetch('pages_partfolio') { self.all }
    end
  end

  def large_picture # большая картинка
    picture.variant(resize: '570x357!').processed
  end
end
