require 'test_helper'

class Shop::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shop_products_index_url
    assert_response :success
  end

  test "should get show" do
    get shop_products_show_url
    assert_response :success
  end

end
