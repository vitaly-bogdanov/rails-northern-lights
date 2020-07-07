require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'попытка создать запись без заполнения поля name' do
    assert_not build(:category, :void_name).valid?
  end
  test 'попытка создать запись без заполнения поля description' do
    assert_not build(:category, :void_description).valid?
  end
  test 'попытка создать запись без запонения поля keywords' do
    assert_not build(:category, :void_keywords).valid?
  end
  test 'попытка создать запись с слишком длинным полем name (больше 12 символов)' do
    assert_not build(:category, :long_name).valid?
  end
  test 'попытка создать запись с указанием всех полей согласно валидационным правилам модели' do
    assert build(:category, :valid_all).valid?
  end
end
