class CreateOrderCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :order_calls do |t|
      t.belongs_to :product
      t.string :name
      t.string :telephone
      t.string :timezone
      t.text :notes
      t.boolean :completed, default: false
      t.boolean :saved, default: false
      t.string :product_name
      t.string :product_price
      t.timestamps
    end
  end
end
