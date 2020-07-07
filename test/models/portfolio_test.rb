require 'test_helper'

class PortfolioTest < ActiveSupport::TestCase
  test 'проба содать запись портфолио' do
    assert Portfolio.new(name: 'New Portfl', description: 't e s t').valid?
  end
  test 'проба создать запись без указания данных для поля description' do
    assert_not Portfolio.new(name: 'New Portfl').valid?
  end
  test 'проба создать запись без указания данных для поля name' do
    assert_not Portfolio.new(description: 't e s t').valid?
  end
end
