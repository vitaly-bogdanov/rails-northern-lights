=begin 
  Товары
=end
class Product < ApplicationRecord
  belongs_to :category
  has_many   :order_calls
  has_one_attached :picture, :dependent => :purge_later

  validates :name,  presence: { message: 'Название товара обязательно' },
                    length: { 
                              maximum: 22, 
                              message: 'Название товара должно иметь длинну максимум 22 символа' 
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
                                    minimum: 100, 
                                    maximum: 800, 
                                    message: 'Описание должно иметь от 100-800 символов' 
                                  }

  validates :preview, presence: { message: 'Краткое описание товара обязательно' },
                      length: { 
                                maximum: 76, 
                                message: 'Краткое описание должно иметь длинну максимум 76 символов' 
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
end
