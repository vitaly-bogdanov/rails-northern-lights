=begin
  "Категории товаров"

  Модель отвечает за классификацию товаров в магазине.
  Имеет связь "один ко м ногим" с товарами.
  Имеет поля: name, description, keywords.
=end
class Category < ApplicationRecord
  # связь "один ко многим"
  has_many :products, dependent: :destroy

  NAME_MAX_LENGTH = 12 # максимальная длинна названия категории

  # настройки slug
  extend FriendlyId
  friendly_id :name, use: :slugged
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
  def should_generate_new_friendly_id?
    name_changed?
  end

  # обязательные поля
  validates :name,
    presence: { message: 'Название категории обязательно' },
    length: { maximum: NAME_MAX_LENGTH, message: 'Законы геометрии не позволяют втеснить такое название' }
  validates :description,
    presence: { message: 'Описание категории обязательно' }
  validates :keywords,
    presence: { message: 'Парочка ключевых слов пригодятся для для SEO оптимизации' }

  def name_max_length
    NAME_MAX_LENGTH
  end

  class << self # статические методы
    def cached_all
      Rails.cache.fetch('all_categories') { self.all }
    end
  end
end
