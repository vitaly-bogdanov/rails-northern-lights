=begin
  Заказ набора товаров
=end
class Order < ApplicationRecord
  # связь "многие ко многим"
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products 

  # валидация инициалов
  validates :initials, presence: { message: 'Укажите ваши данные' }

  # валидация номера телефона
  validates :telephone,
    presence: { message: 'Укажите ваш телефон' },
    format: {
      with: /(\+7|8)[- _]*\(?[- _]*(\d{3}[- _]*\)?([- _]*\d){7}|\d\d[- _]*\d\d[- _]*\)?([- _]*\d){6})/,
      message: 'Не корректный номер'
    }

  # валидация адреса доставки
  validates :region, presence: { message: 'Поле обязательно для заполнения' }
  validates :city, presence: { message: 'Поле обязательно для заполнения' }
  validates :address, presence: { message: 'Поле обязательно для заполнения' }
  validates :postcode,
    presence: { message: 'Поле обязательно для заполнения' },
    numericality: {
      only_float: false,
      less_than_or_equal_to: 999_999,
      message: 'Некорректный почтовый индекс'
    }

  validates :confirm,
    acceptance: {
      accept: '1',
      message: 'Необходимо принять политику приватности'
    }

  validates :confirm,
    acceptance: {
      allow_nil: false,
      message: 'Необходимо принять политику приватности'
    }
end
