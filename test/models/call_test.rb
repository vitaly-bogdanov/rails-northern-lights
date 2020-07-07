require 'test_helper'

class CallTest < ActiveSupport::TestCase
  test 'попытка создать запись без указания имени' do
    assert_not build(:call, :void_name).valid?
  end
  test 'попытка создать запись без указания телефона' do
    assert_not build(:call, :void_telephone).valid?
  end
  test 'попытка создать запись с невалидным мобильным номером РФ' do
    assert_not build(:call, :invalid_telephone).valid?
  end
  test 'попытка создать запись без поля confirm' do
    assert_not build(:call, :not_confirm).valid?
  end
  test 'создание записи при том, что все поля переданны согласно правилам валидации' do
    assert build(:call, :valid_all).valid?
  end
end
