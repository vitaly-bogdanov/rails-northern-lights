require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'попытка создать заказ' do
    assert build(:order, :new_order).valid?
  end
end
