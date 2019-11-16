=begin
  "Портфолио"
  
  Модель отвечает за демонстрационные 
  работы на главной странице в слайдере.
  Имеет три поля: picture, name, description.
=end
class Portfolio < ApplicationRecord
  has_one_attached :picture,  :dependent => :purge_later

  validates :name,        presence: { message: 'Название проекта обязательно' }
  validates :description, presence: { message: 'Описание проекта обязательно' }

  validate :validate_picture # метод находится в ApplicationRecord

  def large_picture
    picture.variant(resize: '570x357!').processed
  end
end
