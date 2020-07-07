class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :initials, null: false, default: ''
      t.string :telephone
      t.string :region
      t.string :city
      t.string :address
      t.integer :postcode
      t.string :comment
      t.string :timezone
      t.integer :tottal_price
      t.string :email, default: ''
      t.text :notes
      t.boolean :completed, default: false
      t.boolean :saved, default: false
      t.boolean :paid, default: false
      t.timestamps
    end
  end
end
