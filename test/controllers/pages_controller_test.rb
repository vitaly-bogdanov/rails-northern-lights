require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    create(:portfolio, :new_portfolio)
    create(:category, :rockets)
    create(:product, :apple)
  end

  # test 'попытка выполнить get запрос pages#index' do
  #   get root_path
  #   assert_response 200
  # end
  test 'попытка выполнить get запрос pages#privacy_agreement' do
    get privacy_agreement_path
    assert_response 200
  end
end
