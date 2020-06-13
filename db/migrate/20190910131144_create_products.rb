class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.belongs_to :category, null: false
      t.string :picture, null: true
      t.string :name, null: false
      t.integer :price, null: false
      t.text :description, null: false
      t.string :preview, null: false
      t.text :keywords, null: false
      t.boolean :available, default: true
      t.boolean :unique
      t.timestamps
    end

    add_index :products, :name # для ускорения поиска
  end
end
