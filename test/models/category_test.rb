require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'попытка создать запись без заполнения поля name' do
    assert_not build(:category, :rockets, name: '').valid?
  end
  test 'попытка создать запись без заполнения поля description' do
    assert_not build(:category, :rockets, description: '').valid?
  end
  test 'попытка создать запись без запонения поля keywords' do
    assert_not build(:category, :rockets, keywords: '').valid?
  end
  test 'попытка создать запись с слишком длинным полем name (больше 12 символов)' do
    assert_not build(:category, :rockets, name:  '1 2 3 4 5 6 7 8 9 10 11 12').valid?
  end
  test 'попытка создать запись с указанием всех полей согласно валидационным правилам модели' do
    assert build(:category, :rockets).valid?
  end
end
