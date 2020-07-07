require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test 'невалидно, если preview имеет длинну меньшую чем 30 символов' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    assert_not Product.new(
      name: 'New Product',
      preview: 'test test test test',
      description: 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test', # от 100 до 650 символов
      price: 200,
      keywords: 'test test',
      unique: false,
      category_id: 1).valid?
  end

  test 'невалидно, если preview имеет длинну большую чем 60 символов' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    assert_not Product.new(
      name: 'New Product',
      preview: 'test test test test test test test test test test test test test test test test test test test test test test test test',
      description: 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test', # от 100 до 650 символов
      price: 200,
      keywords: 'test test',
      unique: false,
      category_id: 1
    ).valid?
  end

  test 'невалидно, если name имеет длинну большую чем 22 символа' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    assert_not Product.new(
      name: '12345678910 12345678910 12345678910', # *
      preview: 'test test test test test test test test test test',
      description: 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test', # от 100 до 650 символов
      price: 200,
      keywords: 'test test',
      unique: false,
      category_id: 1
    ).valid?
  end

  test 'невалидно, если description имеет длинну меньшую чем 100 символа' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    assert_not Product.new(
      name: 'New Product',
      preview: 'test test test test test test test test test test',
      description: 'test test test test', # *
      price: 200,
      keywords: 'test test',
      unique: false,
      category_id: 1
    ).valid?
  end

  test 'невалидно, если description имеет длинну большую чем 650 символа' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    description = '
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
      test test test test test test test test test test test test
    ' # ~ 700 символов
    assert_not Product.new(
      name: 'New Product',
      preview: 'test test test test test test test test test test',
      description: description, # *
      price: 200,
      keywords: 'test test',
      unique: false,
      category_id: 1
    ).valid?
  end

  test 'невалидно, если вместо числа в price переданна строка из символов' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    assert_not Product.new( # все параметры обязательны
      name: 'New Product', # не больше 22 сивлов
      preview: 'test test test test test test test test test test',  # от 30 до 60
      description: 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test', # от 100 до 650 символов
      price: 'fvrervr2000.7',
      keywords: 'test test',
      unique: false,
      category_id: 1
    ).valid?
  end

  test 'невалидно, keywords если передан' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    assert_not Product.new(
      name: 'New Product',
      preview: 'test test test test test test test test test test',  # от 30 до 60
      description: 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test',
      price: 200,
      keywords: '',
      unique: false,
      category_id: 1
    ).valid?
  end

  test 'невалидно, если category, к которой относится product не существует' do
    assert_not Product.new(
      name: 'New Product',
      preview: 'test test test test test test test test test test',
      description: '
        test test test test test 
        test test test test test 
        test test test test test 
        test test test test test 
        test test test test test 
        test test test test test
      ',
      price: 200,
      keywords: 'test test test test',
      unique: false,
      category_id: 10
    ).valid?
  end

  test 'невалидно, если category_id не заается' do
    assert_not Product.new(
      name: 'New Product',
      preview: 'test test test test test test test test test test',
      description: '
        test test test test test 
        test test test test test 
        test test test test test 
        test test test test test 
        test test test test test 
        test test test test test
      ',
      price: 200,
      keywords: 'test test test test',
      unique: false
    ).valid?
  end

  test 'валидно, если все поля переданны правильно' do
    Category.create(
      id: 1,
      name: 'New Cat',
      description: 'Category description',
      keywords: 'test test'
    )
    assert Product.new(
      name: 'New Product',
      preview: 'test test test test test test test test test test',
      description: 'test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test test',
      price: 200,
      keywords: 'test test',
      unique: false,
      category_id: 1
    ).valid?
  end
end
