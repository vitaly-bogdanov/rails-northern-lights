=begin
  "Категории товаров"

  Модель отвечает за классификацию товаров в магазине.
  Имеет связь "один ко м ногим" с товарами.
  Имеет поля: name, description, keywords.
=end
class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  NAME_MAX_LENGTH = 12

  # обязательные поля
  validates :name,        presence: { message: 'Название категории обязательно' },
                          length:   { maximum: NAME_MAX_LENGTH, message: 'Законы геометрии не позволяют втеснить такое название' }
  validates :description, presence: { message: 'Описание категории обязательно' }
  validates :keywords,    presence: { message: 'Парочка ключевых слов пригодятся для для SEO оптимизации' }
end
