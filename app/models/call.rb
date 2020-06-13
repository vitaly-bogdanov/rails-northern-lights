=begin
  Информация, которую пользователь оставляем в
  круглой форме.
=end
class Call < ApplicationRecord
  validates :name,
    presence: { message: 'Напишите как к вам обращаться' }

  validates :telephone,
    presence: { message: 'Укажите пожалуйста ваш телефон' },
    format: {
      with: /(\+7|8)[- _]*\(?[- _]*(\d{3}[- _]*\)?([- _]*\d){7}|\d\d[- _]*\d\d[- _]*\)?([- _]*\d){6})/,
      message: 'Не корректный номер'
    }

  validates :confirm,
    acceptance: {
      allow_nil: false,
      message: 'Необходимо принять политику приватности'
    }

  def get_confirm
    self.confirm
  end
end
