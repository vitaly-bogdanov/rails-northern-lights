require 'test_helper'

class CallTest < ActiveSupport::TestCase
  test 'попытка создать запись без указания имени' do
    assert_not build(:call, :roxanne, name: '').valid?
  end
  test 'попытка создать запись без указания телефона' do
    assert_not build(:call, :roxanne, telephone: '').valid?
  end
  test 'попытка создать запись с невалидным мобильным номером РФ' do
    assert_not build(:call, :roxanne, telephone: '8hnk879bhj7').valid?
  end
  test 'попытка создать запись без поля confirm' do
    assert_not build(:call, :roxanne, confirm: nil).valid?
  end
  test 'создание записи при том, что все поля переданны согласно правилам валидации' do
    assert build(:call, :roxanne).valid?
  end
end
