require 'test_helper'

class Shop::ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = create(:category, :rockets)
    @product = create(:product, :apple)
  end

  test 'попытка выполнить get запрос shop/products#index' do
    get shop_category_products_path(@category.id)
    assert_response 200
  end

  test 'попытка выполнить get запрос shop/products#show' do
    get shop_product_path(@product.id)
    assert @product.has_content?(@product.name)
    assert @product.has_content?(@product.description)
    assert @product.has_content?(@product.price)
    assert_response 200
  end
end
