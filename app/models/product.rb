class Product < ApplicationRecord
  belongs_to :category # связь с категорией
  has_many :order_calls # связь с заказами
  has_one_attached :picture,
    dependent: :purge_later # связь с картинкой, происходит удаление картинки при удалении продукта

  # настройки slug
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  NAME_MAX_LENGTH = 22 # максимальная длинна названия продукта
  PREVIEW_MIN_LENGTH = 30 # минимальная длинна краткого описания товара
  PREVIEW_MAX_LENGTH = 60 # максимальная длинна краткого описания товара
  DESCRIPTION_MIN_LENGTH = 100 # минимальная длинна описания товара
  DESCRIPTION_MAX_LENGTH = 650 # максимальная длинна описания товара

  # валидация названия товара
  validates :name,
    presence: { message: 'Название товара обязательно' },
    length: {
      maximum: NAME_MAX_LENGTH,
      message: "Название товара должно иметь длинну максимум #{NAME_MAX_LENGTH} символа"
    }

  # валидация наличия категории у товара
  validates :category_id, presence: { message: 'Укажите категорию' }

  # валидация цены продукта
  validates :price,
    presence: {
      message: 'Описание проекта обязательно'
    },
    numericality: {
      only_float: true,
      less_than_or_equal_to: 999_999,
      message: 'Значение должно быть числом и максимум шестизначным'
    }

  # валидация описания продукта
  validates :description,
    presence: {
      message: 'Описание товара обязательно'
    },
    length: {
      minimum: DESCRIPTION_MIN_LENGTH,
      maximum: DESCRIPTION_MAX_LENGTH,
      message: "Описание должно иметь длинну от #{DESCRIPTION_MIN_LENGTH} до #{DESCRIPTION_MAX_LENGTH} символов"
    }

  # валидация краткого описания продукта
  validates :preview,
    presence: {
      message: 'Краткое описание товара обязательно'
    },
    length: {
      minimum: PREVIEW_MIN_LENGTH,
      maximum: PREVIEW_MAX_LENGTH,
      message: "Краткое описание должно иметь длинну от #{PREVIEW_MIN_LENGTH} до #{PREVIEW_MAX_LENGTH} символов"
    }

  validates :keywords, presence: { message: 'Ключевые слова обязательны' }

  validate :validate_picture # метод находится в ApplicationRecord

  def large_picture # метод вызова большой картинки
    # begin
      picture.variant(resize: '540x426!').processed
    # rescue => exception
    #   'No Image'
    # end
  end

  def middle_picture # метод вызова средней картинки
    picture.variant(resize: '270x213!').processed
  end

  def thumb_picture # метод вызова маленькой картинки
    picture.variant(resize: '135x107!').processed
  end

  def search_picture # маленькая картинка в поиске (выключенно)
    picture.variant(resize: '50x50!').processed
  end

  def description_min_length
    DESCRIPTION_MIN_LENGTH
  end

  def description_max_length
    DESCRIPTION_MAX_LENGTH
  end

  def preview_max_length
    PREVIEW_MAX_LENGTH
  end

  def preview_min_length
    PREVIEW_MIN_LENGTH
  end

  def name_max_length
    NAME_MAX_LENGTH
  end
end
