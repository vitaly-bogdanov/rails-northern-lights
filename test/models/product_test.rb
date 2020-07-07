require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'валидно, если все поля переданны правильно' do
    assert build(:product, :apple).valid?
  end
  test 'невалидно, если preview имеет длинну меньшую чем 30 символов' do
    assert_not build(:product, :apple, preview: 'test test test test').valid?
  end
  test 'невалидно, если preview имеет длинну большую чем 60 символов' do
    preview = '
      test test test test 
      test test test test 
      test test test test 
      test test test test 
      test test test test 
      test test test test
    '
    assert_not build(:product, :apple, preview: preview).valid?
  end
  test 'невалидно, если name имеет длинну большую чем 22 символа' do
    assert_not build(:product, :apple, name: '12345678910 12345678910 12345678910').valid?
  end
  test 'невалидно, если description имеет длинну меньшую чем 100 символа' do
    assert_not build(:product, :apple, description: 'test test test test').valid?
  end
  test 'невалидно, если description имеет длинну большую чем 650 символа' do
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
    '
    assert_not build(:product, :apple, description: description).valid?
  end
  test 'невалидно, если вместо числа в price переданна строка из символов' do
    assert_not build(:product, :apple, price: 'fvrervr2000.7').valid?
  end
  test 'невалидно, если поле keywords пусто' do
    assert_not build(:product, :apple, keywords: '').valid?
  end
end
