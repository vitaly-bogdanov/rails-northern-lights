class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.belongs_to :product
      t.belongs_to :order
      t.integer :count_products
      t.integer :products_price
      t.integer :unit_price
      t.string :product_name
      t.timestamps
    end
  end
end
