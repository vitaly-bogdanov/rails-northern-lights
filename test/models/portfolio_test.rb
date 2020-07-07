require 'test_helper'

class PortfolioTest < ActiveSupport::TestCase
  test 'проба содать запись портфолио' do
    assert build(:portfolio, :new_portfolio).valid?
  end
  test 'проба создать запись без указания данных для поля description' do
    assert_not build(:portfolio, :new_portfolio, description: '').valid?
  end
  test 'проба создать запись без указания данных для поля name' do
    assert_not build(:portfolio, :new_portfolio, name: '').valid?
  end
end
