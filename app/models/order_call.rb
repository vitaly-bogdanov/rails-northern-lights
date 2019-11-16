class OrderCall < ApplicationRecord
  belongs_to :product

  validates :name,      presence: { message: 'Укажите ваше имя' }
  validates :telephone, presence: { message: 'Укажите ваш телефон' },
                          format: {
                            with: /(\+7|8)[- _]*\(?[- _]*(\d{3}[- _]*\)?([- _]*\d){7}|\d\d[- _]*\d\d[- _]*\)?([- _]*\d){6})/, 
                            message: 'Не корректный номер' 
                          }
  validates :confirm, acceptance: { allow_nil: false, message: 'Необходимо принять политику приватности' }
end
