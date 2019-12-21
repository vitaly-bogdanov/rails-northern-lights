=begin 
  Товары
=end
class Product < ApplicationRecord
  belongs_to :category
  has_many   :order_calls
  has_one_attached :picture, :dependent => :purge_later

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  NAME_MAX_LENGTH = 22

  PREVIEW_MIN_LENGTH = 30
  PREVIEW_MAX_LENGTH = 60

  DESCRIPTION_MIN_LENGTH = 100
  DESCRIPTION_MAX_LENGTH = 650

  validates :name, presence: { message: 'Название товара обязательно' },
                     length: { 
                               maximum: NAME_MAX_LENGTH, 
                               message: "Название товара должно иметь длинну максимум #{NAME_MAX_LENGTH} символа" 
                             }

  validates :category_id, presence: { message: 'Укажите категорию' }

  validates :price, presence: { message: 'Описание проекта обязательно' },
                numericality: { 
                                only_float: true, 
                                less_than_or_equal_to: 999999, 
                                message: 'Значение должно быть числом и максимум шестизначным' 
                              }

  validates :description, presence: { message: 'Описание товара обязательно' },
                            length: { 
                                      minimum: DESCRIPTION_MIN_LENGTH, 
                                      maximum: DESCRIPTION_MAX_LENGTH, 
                                      message: "Описание должно иметь длинну от #{DESCRIPTION_MIN_LENGTH} до #{DESCRIPTION_MAX_LENGTH} символов" 
                                    }

  validates :preview, presence: { message: 'Краткое описание товара обязательно' },
                        length: { 
                                  minimum: PREVIEW_MIN_LENGTH,
                                  maximum: PREVIEW_MAX_LENGTH, 
                                  message: "Краткое описание должно иметь длинну от #{PREVIEW_MIN_LENGTH} до #{PREVIEW_MAX_LENGTH} символов"
                                }

  validates :keywords, presence: { message: 'Ключевые слова обязательны' }

  validate :validate_picture # метод находится в ApplicationRecord

  def large_picture
    picture.variant(resize: '540x426!').processed
  end

  def middle_picture
    picture.variant(resize: '270x213!').processed
  end

  def thumb_picture
    picture.variant(resize: '135x107!').processed
  end

  def search_picture
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
