=begin
  Модель заказов   
=end

class Order < ApplicationRecord
  has_many :order_product, dependent: :destroy
  has_many :product, through: :order_product

  validates :initials,  presence: { message: 'Укажите ваши данные' }
  validates :telephone, presence: { message: 'Укажите ваш телефон' },
                          format: {
                            with: /(\+7|8)[- _]*\(?[- _]*(\d{3}[- _]*\)?([- _]*\d){7}|\d\d[- _]*\d\d[- _]*\)?([- _]*\d){6})/, 
                            message: 'Не корректный номер' 
                          }
  validates :region,   presence: { message: 'Поле обязательно для заполнения' }
  validates :city,     presence: { message: 'Поле обязательно для заполнения' }
  validates :address,  presence: { message: 'Поле обязательно для заполнения' }

  validates :postcode, presence: { message: 'Поле обязательно для заполнения' },
                       numericality: { 
                         only_float: false, 
                         less_than_or_equal_to: 999999, 
                         message: 'Некорректный почтовый индекс' 
                       }

  validates :confirm, acceptance: { accept: '1', message: 'Необходимо принять политику приватности' }
  validates :confirm, acceptance: { allow_nil: false, message: 'Необходимо принять политику приватности' }

  # t.string  :initials
  # t.string  :telephone
  # t.string  :region
  # t.string  :city
  # t.string  :address
  # t.string  :postcode
  # t.string  :comment
  # t.string  :timezone
  # t.text    :notes
  # t.boolean :completed, default: false
  # t.boolean :saved,     default: false
  # t.boolean :paid,      default: false

end
