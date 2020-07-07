require 'test_helper'

class OrderCallTest < ActiveSupport::TestCase
  test 'попытка создать запись оставив поле name пустым' do
    assert_not build(:order_call, :new_order_call, name: '').valid?
  end
  test 'попытка создать запись с невалидным номером телефона' do
    assert_not build(:order_call, :new_order_call, telephone: '89j8hk98j8').valid?
  end
  test 'попытка создать запись без заполнения поля confirm' do
    assert_not build(:order_call, :new_order_call, confirm: nil).valid?
  end
  test 'попытка создать запись при заполнении всех полей согласно правилам валидации' do
    assert build(:order_call, :new_order_call).valid?
  end
end
